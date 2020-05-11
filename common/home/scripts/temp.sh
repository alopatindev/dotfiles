#!/bin/bash

SENSORS_OUT=$(sensors)

for i in $(echo "${SENSORS_OUT}" | grep -v ^T | grep : | egrep -o '(.*?): *(\+[0-9.-]*)°C '); do
    echo -n "$i "
done | sed 's/°C / °C\n/g'
#nvidia-smi --format=csv,noheader --query-gpu=temperature.gpu | grep -v NVIDIA

echo
echo "${SENSORS_OUT}" | grep RPM

cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
grep MHz /proc/cpuinfo | sed 's!.*: !!;s!\..*!!' | tr '\r\n' ' '
