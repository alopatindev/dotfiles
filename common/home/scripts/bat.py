#!/bin/env python

statf = file("/sys/class/power_supply/BAT0/status")
t = statf.read()
statf.close()
nowf = file("/sys/class/power_supply/BAT0/charge_now")
fullf = file("/sys/class/power_supply/BAT0/charge_full")
now = nowf.read()
full = fullf.read()
nowf.close()
fullf.close()
p = (int(now) * 100) / int(full)
print p
