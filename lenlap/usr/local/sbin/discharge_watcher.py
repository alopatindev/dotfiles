#!/bin/env python3

import os
import time

MIN_PERCENT = 15

while True:
    time.sleep(60 * 3)
    try:
        statf = open("/sys/class/power_supply/BAT0/status")
        t = statf.read()
        statf.close()
        if (t != "Discharging\n"):
            continue
        nowf = open("/sys/class/power_supply/BAT0/energy_now")
        fullf = open("/sys/class/power_supply/BAT0/energy_full")
        now = nowf.read()
        full = fullf.read()
        nowf.close()
        fullf.close()
        p = (int(now) * 100) / int(full)
        if p < MIN_PERCENT:
            os.system("/usr/local/sbin/hibernate")
    except:
        pass
