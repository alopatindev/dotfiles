#!/bin/bash

GOV=$1
#GOV=powersave

if [[ $1 == '' ]]; then
    echo "$0 [powersave | ondemand | performance]"
elif [[ "${GOV}" != $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) ]]; then
    logger "$0: switching to ${GOV}"
    for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo -n "${GOV}" > $i
    done

    if [[ ${GOV} == powersave ]]; then
        echo -n 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
        echo -n 30 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
    else
        echo -n 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
        echo -n 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
    fi
fi

