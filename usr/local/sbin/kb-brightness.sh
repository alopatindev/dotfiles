#!/bin/bash

kbdb='/sys/devices/platform/applesmc.768/leds/smc::kbd_backlight/brightness'
step=25
current=$(cat $kbdb)
new=$current

if [ "$1" == "up" ]; then
   #new=$(($current + $step))
   new=$(($current + 1))
elif [ "$1" == "down" ]; then 
   #new=$(($current - $step))
   new=$(($current - 1))
fi

if [ $new -le 0 ]; then
   new=0
fi

logger "changing keyboard brightness to $new"

echo -n $new > $kbdb
