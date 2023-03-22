#!/bin/env python3

import os
import time
from syslog import syslog

#MIN_PERCENT = 15
MIN_PERCENT = 50
CRITICAL_PERCENT = 5

def read_battery_data(item):
    with open('/sys/class/power_supply/BAT0/' + item) as f:
        return f.read().strip()

while True:
    time.sleep(60)
    try:
        if (read_battery_data('status') != "Discharging"):
            continue
        now = read_battery_data("charge_now")
        full = read_battery_data("charge_full")
        p = (int(now) * 100) / int(full)
        p = int(p)
        syslog('discharging %d' % p)
        if p < MIN_PERCENT:
            syslog('running out of battery, let us hibernate now')
            os.system("/usr/local/sbin/hibernate")
        elif p <= CRITICAL_PERCENT:
            syslog('something went wrong, running halt')
            os.system('halt')
    except Exception as e:
        syslog('discharge_watcher failure ' + str(e))
        pass
