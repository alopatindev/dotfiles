#!/bin/bash

set -e

MULTIPLIER=${2:-2}
BR=$(cat /sys/class/backlight/dell_backlight/brightness)
GAMMA=$(xgamma 2>>/dev/stdout | awk '{print $7}')

case $1 in
    up)
        BR=$(echo "$BR * $MULTIPLIER" | bc)
        #xgamma -gamma $(echo "${GAMMA} + 0.2" | bc)
        ;;
    down)
        BR=$(echo "$BR / $MULTIPLIER" | bc)
        #xgamma -gamma $(echo "${GAMMA} - 0.2" | bc)
        ;;
    max)
        BR=937
        xgamma -gamma 1
        ;;
    *)
        echo "syntax $0 [up | down | max] [multiplier]"
        exit 1
        ;;
esac

logger "change brightness to $BR"
echo -n $BR > /sys/class/backlight/dell_backlight/brightness
