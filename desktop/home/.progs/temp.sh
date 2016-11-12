#!/bin/bash

SENSORS_OUT=$(sensors)

for i in $(echo "${SENSORS_OUT}" | grep -v ^T | grep : | egrep -o '(.*?): *(\+[0-9.-]*)°C '); do
    echo -n "$i "
done | sed 's/°C / °C\n/g'

echo
echo "${SENSORS_OUT}" | grep RPM

echo
(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ; grep MHz /proc/cpuinfo | cut -d':' -f2) | column -c 40
