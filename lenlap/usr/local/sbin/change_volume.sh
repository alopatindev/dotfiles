#!/bin/bash

STEP=3

#DEV=Headphone
DEV=Master

VOL=$(amixer sget ${DEV}|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')
amixer -q sset ${DEV} "${STEP}%${1}"
VOL=$(amixer sget ${DEV}|grep 'Mono:'|awk '{print $4}'|sed 's/\[//g'|sed 's/\%\]//g')

# vim: textwidth=0
