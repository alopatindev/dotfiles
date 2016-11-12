#!/bin/bash

WIDTH=200
HEIGHT=50
STEP=10
#DISPLAY=:0

STAT=$(amixer sget Master|egrep -o '\[(on|off)\]'|\
       sed 's/\[//g'|sed 's/\]//g'|tr '[:lower:]' '[:upper:]')

echo "   ^fg(#ebca40)Sound ${STAT}" | ~/.progs/dzen/dzen2 -fn "DejaVu Sans:size=${HEIGHT}" -p 1 -ta l -y 20

# vim: textwidth=0
