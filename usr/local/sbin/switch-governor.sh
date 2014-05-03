#!/bin/bash

if [[ $1 == '' ]]; then
    echo "$0 [powersave | ondemand | performance]"
elif [[ $1 != $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) ]]; then
    logger "$0: switching to $1"
    for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo -n "$1" > $i
    done
    #cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
fi

