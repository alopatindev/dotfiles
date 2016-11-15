#!/bin/bash

# $@ == 1280 960 85

OUT=VGA1

if [[ $2 == '' ]] ; then
    echo "syntax: $0 1280 960 [85] [VGA1 | LVDS1]"
    exit 1
fi

if [[ $4 == '' ]]; then
    OUT=VGA1
else
    OUT=$4
fi

MODELINE=$(cvt $1 $2 $3 | grep Modeline | sed 's/"//g')
MODE=$(echo ${MODELINE} | awk '{print $2}')

#FIXME
M=$(echo ${MODELINE} | awk '{print $3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}')
#MM="${1}x${2}"

xrandr --output $OUT --mode ${MODE} || (
    echo 'no such mode. gonna add it.'
    xrandr --newmode ${MODE} ${M}
    xrandr --addmode ${OUT} ${MODE}
    xrandr --output $OUT --mode ${MODE}
)

#xrandr --delmode ${OUT} ${MODE}
#xrandr --rmmod ${MODE}
