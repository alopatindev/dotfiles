#!/bin/bash

WIDTH=200
HEIGHT=50
STEP=10
#DISPLAY=:0

VOL=$(amixer sget Master|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
amixer -q sset Master "${STEP}%${1}"
VOL=$(amixer sget Master|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
echo 'volume:'$VOL
P=$((${VOL}*${WIDTH}/100))

echo "   ^fg(#ebca40)Volume: ${VOL}% ^ro(${WIDTH}x${HEIGHT})^p(-${WIDTH})^r(${P}x${HEIGHT})" | ~/.bin/dzen2-svn -fn "DejaVu Sans:size=${HEIGHT}" -p 1 -ta l -y 20

# vim: textwidth=0
