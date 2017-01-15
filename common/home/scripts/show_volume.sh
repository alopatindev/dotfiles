#!/bin/bash

WIDTH=700
HEIGHT=65

#DEV=Headphone
DEV=Master

VOL=$(amixer sget ${DEV}|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
P=$((${VOL}*${WIDTH}/100))

MUT=$(amixer sget ${DEV}|grep 'Mono:'|awk '{print $6}')
if [ $MUT == "[on]" ]; then
    MUT=""
else
    MUT="(muted) "
fi

echo "   ^fg(#ebca40)${MUT}Volume: ${VOL}% ^ro(${WIDTH}x${HEIGHT})^p(-${WIDTH})^r(${P}x${HEIGHT})" | dzen2 -fn "DejaVu Sans:size=${HEIGHT}" -p 1 -ta l -y 20

# vim: textwidth=0
