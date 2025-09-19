#!/bin/bash

(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor | tr '\n' ':' ; echo -n ' ' ; grep MHz /proc/cpuinfo | sed 's!.*: !!;s!\..*!!') | tr '\r\n' ' '

echo

SENSORS_OUT=$(sensors)
(
    echo 'temp:'
    for i in $(echo "${SENSORS_OUT}" | grep -v ^T | grep : | egrep -o '(.*?): *(\+[0-9.-]*)°C '); do
        echo -n "$i "
    done | sed 's/°C /°C\n/g'
    echo '°C'
) | sed 's!.*: !!' | tr '\r\n' ' ' | sed 's! °C!°C!g;s!\+!!g;s!°C!!g'
echo '°C'

echo -n 'nvidia: '
#nvidia-smi --format=csv,noheader --query-gpu=temperature.gpu | grep -v NVIDIA
/usr/local/bin/nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | tr '\r\n' ' '
echo -n '°C '

echo -n ' RPM: '
echo "${SENSORS_OUT}" | grep RPM | awk '{print $2}' | tr '\r\n' ' '
echo "NVMe: $(cat /tmp/.nvme-temp | tr '\r\n' ' ')°C"
