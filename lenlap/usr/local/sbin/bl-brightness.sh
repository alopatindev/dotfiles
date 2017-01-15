#!/bin/bash

set -e

DELTA=50
BR=$(cat /sys/class/backlight/intel_backlight/brightness)

case $1 in
    up)
        BR=$(echo "$BR + $DELTA" | bc)
        ;;
    down)
        BR=$(echo "$BR - $DELTA" | bc)
        ;;
    *)
        echo "syntax $0 [up | down]"
        exit 1
        ;;
esac

logger "change brightness to $BR"
echo -n $BR > /sys/class/backlight/intel_backlight/brightness
