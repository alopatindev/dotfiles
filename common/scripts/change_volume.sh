#!/bin/bash

WIDTH=700
HEIGHT=65
STEP=3
#DISPLAY=:0

VOL=$(amixer sget Headphone|grep 'Front Left:'|awk '{print $5}'|sed 's/\[//g'|sed 's/\%\]//g')
amixer -q sset Headphone "${STEP}%${1}"
VOL=$(amixer sget Headphone|grep 'Front Left:'|awk '{print $5}'|sed 's/\[//g'|sed 's/\%\]//g')
echo 'volume:'$VOL
P=$((${VOL}*${WIDTH}/100))

MUT=$(amixer sget Headphone|grep 'Front Left:'|awk '{print $7}')
if [ $MUT == "[on]" ]; then
    MUT=""
else
    MUT="(muted) "
fi

echo "   ^fg(#ebca40)${MUT}Volume: ${VOL}% ^ro(${WIDTH}x${HEIGHT})^p(-${WIDTH})^r(${P}x${HEIGHT})" | ~/.bin/dzen2-svn -fn "DejaVu Sans:size=${HEIGHT}" -p 1 -ta l -y 20

# vim: textwidth=0
