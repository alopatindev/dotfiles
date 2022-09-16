#!/bin/bash

GOV=$1
#GOV=powersave

echo $GOV

if [[ $1 == '' ]]; then
    echo "$0 [powersave | ondemand | performance]"
elif [[ "${GOV}" != $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) ]]; then
    logger "$0: switching to ${GOV}"
    for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo -n "${GOV}" > $i
    done
fi

