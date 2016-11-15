#!/bin/bash

WIDTH=700
HEIGHT=65
STEP=10
#DISPLAY=:0

VOL=$(amixer sget Master|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
amixer -q sset Master "${STEP}%${1}"
VOL=$(amixer sget Master|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
echo 'volume:'$VOL
P=$((${VOL}*${WIDTH}/100))

MUT=$(amixer sget Master|grep 'Mono:'|awk '{print $6}')
if [ $MUT == "[on]" ]; then
    MUT=""
else
    MUT="(muted) "
fi

echo "   ^fg(#ebca40)${MUT}Volume: ${VOL}% ^ro(${WIDTH}x${HEIGHT})^p(-${WIDTH})^r(${P}x${HEIGHT})" | ~/.bin/dzen2-svn -fn "DejaVu Sans:size=${HEIGHT}" -p 1 -ta l -y 20

# vim: textwidth=0
