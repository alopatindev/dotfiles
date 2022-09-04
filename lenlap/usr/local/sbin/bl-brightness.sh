#!/bin/bash

set -e

MULTIPLIER=${2:-2}
BR=$(cat /sys/class/backlight/intel_backlight/brightness)

case $1 in
    up)
        BR=$(echo "$BR * $MULTIPLIER" | bc)
        ;;
    down)
        BR=$(echo "$BR / $MULTIPLIER" | bc)
        ;;
    max)
        BR=937
        ;;
    *)
        echo "syntax $0 [up | down | max] [multiplier]"
        exit 1
        ;;
esac

logger "change brightness to $BR"
echo -n $BR > /sys/class/backlight/intel_backlight/brightness
