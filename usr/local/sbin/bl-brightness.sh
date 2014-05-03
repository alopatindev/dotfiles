#!/bin/bash
bldb='/sys/class/backlight/acpi_video0/brightness'
step=8
current=`cat $bldb`
new=$current
if [ "$1" == "up" ];then
   new=$(($current + $step))
elif [ "$1" == "down" ];then 
   new=$(($current - $step))
fi
if [ $new -le 0 ];then
   new=0
fi
logger "chaning background brightness to $new"
echo $new > $bldb
current=`cat $bldb`
