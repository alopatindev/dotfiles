#!/bin/env python

import os
import time

while True:
    time.sleep(60 * 3)
    try:
        statf = file("/sys/class/power_supply/BAT0/status")
        t = statf.read()
        statf.close()
        if (t != "Discharging\n"):
            continue
        nowf = file("/sys/class/power_supply/BAT0/energy_now")
        fullf = file("/sys/class/power_supply/BAT0/energy_full")
        now = nowf.read()
        full = fullf.read()
        nowf.close()
        fullf.close()
        p = (int(now) * 100) / int(full)
        if p <= 21:
            os.system("/usr/local/sbin/standby")
    except:
        pass
