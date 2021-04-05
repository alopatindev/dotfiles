#!/bin/env python3

# TODO: split bulbs in groups: room, room-under-table, kitchen
# TODO: control bulbs individually?
# TODO: standby-and-lights-off => I'm not home mode?

from copy import copy
import os
from random import shuffle, random, randrange
import sys
import time
import traceback
from yeelight import *

# 104 is under table, 103 and 101 (and 100?) are kitchen
BULBS_IPV4_LAST_PARTS = [104, 105, 102, 100, 103, 101]
BULBS = ["192.168.1.%d" % i for i in BULBS_IPV4_LAST_PARTS]
MAX_TEMPERATURE = 6500
#MAX_TEMPERATURE = 5000
MAX_BRIGHTNESS = 100
#MAX_BRIGHTNESS = 40 # WAT
MIN_BRIGHTNESS = 1700

# FIXME: MAX_BRIGHTNESS is misused?

if len(sys.argv) < 2:
    print('%s [sunrise-if-off|sunset] [duration_in_minutes] [lag_between_bulbs_in_minutes]' % (sys.argv[0]))
    print('%s [on|off|work|rest|romantic]' % (sys.argv[0]))
    sys.exit(1)

action = sys.argv[1]
if action == 'sunrise-if-off' or action == 'sunset':
    duration_mins = float(sys.argv[2])
    lag_between_bulbs_mins = float(sys.argv[3])
    duration_secs = duration_mins * 60
    lag_between_bulbs_secs = lag_between_bulbs_mins * 60
    duration_ms = duration_secs * 1000
    pre_part_duration_ms = 50
    post_part_duration_ms = 5000
    main_parts = 2
    main_part_duration_ms = duration_ms / main_parts
    assert duration_ms >= pre_part_duration_ms + post_part_duration_ms
    last_main_part_duration_ms = main_part_duration_ms - pre_part_duration_ms - post_part_duration_ms

#bulbs = [Bulb(ip=i, effect='smooth', duration=5000, power_mode=PowerMode.RGB) for i in BULBS]
bulbs = [Bulb(ip=i, effect='smooth', duration=5000, power_mode=PowerMode.NORMAL) for i in BULBS]

def wait_until_duration():
    time.sleep(duration_secs - lag_between_bulbs_secs * len(bulbs))

def wait_until_lag():
    time.sleep(lag_between_bulbs_secs)

def get_max_values():
    brightness = MAX_BRIGHTNESS
    temperature = MAX_TEMPERATURE
    for bulb in bulbs:
        try:
            properties = bulb.get_properties()
            current_brightness = int(properties['bright'])
            current_temperature = int(properties['ct'])
            brightness = min(brightness, current_brightness)
            temperature = min(temperature, current_temperature)
        except main.BulbException as e:
            traceback.print_exc()
    return brightness, temperature

def sunrise():
    max_brightness, max_temperature = get_max_values()
    min_temperature = max(MIN_BRIGHTNESS, max_temperature)
    min_brightness = max(1, max_brightness)
    transitions = [
        TemperatureTransition(min_temperature, duration=pre_part_duration_ms, brightness=min_brightness),
        TemperatureTransition(max(2100, max_temperature), duration=main_part_duration_ms, brightness=max(50, max_brightness)),
        TemperatureTransition(max(5000, max_temperature), duration=last_main_part_duration_ms, brightness=MAX_BRIGHTNESS),
        TemperatureTransition(MAX_TEMPERATURE, duration=post_part_duration_ms, brightness=MAX_BRIGHTNESS),
    ]
    pre_post_parts = 2
    assert main_parts == len(transitions) - pre_post_parts

    for bulb in bulbs:
        try:
            #bulb.turn_off()
            bulb.set_color_temp(min_temperature)
            bulb.set_brightness(min_brightness)
        except main.BulbException as e:
            traceback.print_exc()

    for bulb in bulbs:
        try:
            bulb.get_properties()
            bulb.turn_on()
            time.sleep(5)
            bulb.start_flow(flow=Flow(count=1, action=flow.Action.stay, transitions=transitions))
            wait_until_lag()
        except main.BulbException as e:
            traceback.print_exc()
    wait_until_duration()

    ##wait_until_duration()
    ##xmas()
    #hour_secs = 60 * 60
    #time.sleep(hour_secs)
    #wake_me()

def sunset():
    max_brightness, max_temperature = get_max_values()
    transitions = [
        TemperatureTransition(max_temperature, duration=pre_part_duration_ms, brightness=max_brightness),
        TemperatureTransition(min(5000, max_temperature), duration=last_main_part_duration_ms, brightness=max_brightness),
        TemperatureTransition(min(2100, max_temperature), duration=main_part_duration_ms, brightness=min(50, max_brightness)),
        TemperatureTransition(MIN_BRIGHTNESS, duration=post_part_duration_ms, brightness=1),
    ]
    pre_post_parts = 2
    assert main_parts == len(transitions) - pre_post_parts

    for bulb in bulbs:
        try:
            bulb.set_color_temp(max_temperature)
            bulb.get_properties()
            bulb.start_flow(flow=Flow(count=1, action=flow.Action.stay, transitions=transitions))
            #bulb.set_scene(SceneClass.CT, flow)
            wait_until_lag()
        except main.BulbException as e:
            traceback.print_exc()

    wait_until_duration()

#def off(with_lags):
#    for bulb in bulbs:
#        try:
#            if bulb.get_properties()['power'] == 'on':
#                bulb.set_color_temp(1)
#                time.sleep(10)
#                bulb.turn_off()
#                if with_lags:
#                    wait_until_lag()
#        except main.BulbException as e:
#            traceback.print_exc()

def off(with_lags):
    # TODO: similar to dim_light
    for bulb in bulbs:
        try:
            if bulb.get_properties()['power'] == 'on':
                bulb.set_rgb(0x74, 0, 0)
                #bulb.set_color_temp(1)
                bulb.set_brightness(1)
        except main.BulbException as e:
            traceback.print_exc()

    time.sleep(5)

    for bulb in bulbs:
        try:
            if bulb.get_properties()['power'] == 'on':
                bulb.turn_off()
                if with_lags:
                    wait_until_lag()
        except main.BulbException as e:
            traceback.print_exc()

def on():
    for bulb in bulbs:
        try:
            bulb.get_properties()
            bulb.turn_on()
        except main.BulbException as e:
            traceback.print_exc()

def dim_light(with_lags):
    for bulb in bulbs:
        try:
            bulb.get_properties()
            bulb.set_color_temp(MIN_BRIGHTNESS)
            bulb.set_brightness(1)
        except main.BulbException as e:
            traceback.print_exc()
    off_all_but_bulb_per_room(with_lags)

def off_all_but_bulb_per_room(with_lags):
    allowed_bulbs = [102, 100]
    ips = ["192.168.1.%d" % i for i in BULBS_IPV4_LAST_PARTS if i not in allowed_bulbs] # TODO: refactoring
    for bulb in bulbs:
        try:
            if bulb._ip in ips:
                bulb.get_properties()
                bulb.turn_off()
            if with_lags:
                wait_until_lag()
        except main.BulbException as e:
            traceback.print_exc()

def rest():
    max_brightness, max_temperature = get_max_values()
    for bulb in bulbs:
        try:
            bulb.set_color_temp(MIN_BRIGHTNESS)
            bulb.set_brightness(min(50, max_brightness))
        except main.BulbException as e:
            traceback.print_exc()

def rest2():
    bulb_under_table = bulbs[0]
    bulbs_to_turn_off = [bulb_under_table] + bulbs[3:]
    max_brightness, max_temperature = get_max_values()
    for bulb in bulbs:
        try:
            #bulb.set_color_temp(MIN_BRIGHTNESS)
            #bulb.set_rgb(0x74, 0, 0)
            bulb.set_color_temp(MIN_BRIGHTNESS)
            bulb.set_brightness(1)
        except main.BulbException as e:
            traceback.print_exc()
    for bulb in bulbs_to_turn_off:
        try:
            if bulb.get_properties()['power'] == 'on':
                time.sleep(5)
                bulb.turn_off()
        except main.BulbException as e:
            traceback.print_exc()

def rest3():
    bulb_under_table = bulbs[0]
    bulbs_to_turn_off = bulbs[1:]
    max_brightness, max_temperature = get_max_values()
    for bulb in bulbs:
        try:
            #bulb.set_color_temp(MIN_BRIGHTNESS)
            #bulb.set_rgb(0x74, 0, 0)
            bulb.set_color_temp(MIN_BRIGHTNESS)
            bulb.set_brightness(1)
        except main.BulbException as e:
            traceback.print_exc()
    for bulb in bulbs_to_turn_off:
        try:
            if bulb.get_properties()['power'] == 'on':
                time.sleep(5)
                bulb.turn_off()
        except main.BulbException as e:
            traceback.print_exc()

def romantic():
    max_brightness, max_temperature = get_max_values()
    for bulb in bulbs:
        try:
            #bulb.set_color_temp(2100)
            #bulb.set_rgb(118, 12, 65) # purple
            #bulb.set_rgb(116, 255, 107) # green
            bulb.set_rgb(107, 107, 107)
            bulb.set_brightness(min(50, max_brightness))
        except main.BulbException as e:
            traceback.print_exc()

#def work():
#    bulb_under_table_is_off = False
#    for bulb in bulbs:
#        try:
#            if not bulb_under_table_is_off:
#                bulb.turn_off()
#                bulb_under_table_is_off = True
#                continue
#            bulb.set_color_temp(MAX_TEMPERATURE)
#            bulb.set_brightness(MAX_BRIGHTNESS)
#        except main.BulbException as e:
#            traceback.print_exc()

def work():
    bulb_under_table = bulbs[0]
    bulbs_to_turn_off = [bulb_under_table] + bulbs[3:]
    other_bulbs = bulbs[1:-2]

    for bulb in other_bulbs:
        try:
            bulb.set_color_temp(MAX_TEMPERATURE)
            bulb.set_brightness(MAX_BRIGHTNESS)
        except main.BulbException as e:
            traceback.print_exc()

    for bulb in bulbs_to_turn_off:
        try:
            if bulb.get_properties()['power'] == 'on':
                bulb.set_color_temp(1)
                bulb.set_brightness(1)
                time.sleep(5)
                bulb.turn_off()
        except main.BulbException as e:
            traceback.print_exc()


def wake_me():
    white = [0xFF, 0xFF, 0xFF]
    purple = [0xFF, 0x00, 0xDE]
    colors = [white, purple]

    for bulb in bulbs:
        try:
            bulb.set_brightness(MAX_BRIGHTNESS)
        except main.BulbException as e:
            traceback.print_exc()

    while True:
        for color in colors:
            for bulb in bulbs:
                try:
                    bulb.set_rgb(*color)
                    #bulb.set_brightness(100)
                except main.BulbException as e:
                    traceback.print_exc()
            time.sleep(10)


def xmas():
    bs = [Bulb(ip=i, effect='sudden', duration=1, power_mode=PowerMode.NORMAL) for i in BULBS]
    print(bulbs)
    for bulb in bs:
        try:
            bulb.set_color_temp(MAX_TEMPERATURE)
            bulb.set_brightness(MAX_BRIGHTNESS)
        except main.BulbException as e:
            traceback.print_exc()

    while True:
        #shuffle(bs)
        delay = 0
        for bulb in bs:
            #try:
            #r, g, b = [int(random() * (0xff + 1)) for _ in range(3)]
            r, g, b = [ord(os.urandom(1)) for _ in range(3)]
            bulb.set_rgb(r, g, b)
            #bulb.set_brightness(int(random() * abs(MAX_BRIGHTNESS - MIN_BRIGHTNESS)))
            bulb.set_brightness(MAX_BRIGHTNESS + int(random() * abs(MAX_BRIGHTNESS - MIN_BRIGHTNESS)))
            #except main.BulbException as e:
            #    traceback.print_exc()
            max_delay_secs = 10
            #delay = randrange_distinct(5, max_delay_secs, delay) / max_delay_secs
            #delay = 2
            delay = 1.5
            print(delay)
            time.sleep(delay)

def randrange_distinct(start, stop, prev):
    found = False
    #threshold = (stop - start) / 7
    threshold = 0.5
    while True:
        value = randrange(start, stop=stop) / stop
        delta_value = (abs(value - prev))
        print(value, delta_value)
        if delta_value >= threshold:
            print('found')
            return value


def is_off():
    for bulb in bulbs:
        try:
            if bulb.get_properties()['power'] == 'on':
                return False
        except main.BulbException as e:
            traceback.print_exc()
    return True

os.system("logger '{}'".format(sys.argv))
print(action)
if action == 'sunrise-if-off':
    # TODO: check whether current mode is "work"? check on a higher level?
    if is_off():
        sunrise()
    else:
        print('not running sunrise')
elif action == 'sunset': # TODO: if-on?
    sunset()
    #off(with_lags=True)
    #off_all_but_bulb_per_room(with_lags=False)
elif action == 'off':
    off(with_lags=False)
elif action == 'on':
    on()
elif action == 'rest':
    on()
    rest()
elif action == 'rest2':
    on()
    rest2()
elif action == 'rest3':
    on()
    rest3()
elif action == 'romantic':
    romantic()
elif action == 'work':
    # TODO: rewrite transitions?
    work()
elif action == 'xmas':
    on()
    xmas()
elif action == 'off_all_but_bulb_per_room':
    off_all_but_bulb_per_room(with_lags=False)
elif action == 'dim_light':
    dim_light(with_lags=False)
elif action == 'wake_me':
    wake_me()
else:
    raise NotImplementedError
