#!/bin/bash

STATE=$(synclient -l|grep TouchpadOff|awk '{print $3}')
if [[ $STATE -eq 1 ]]; then
    synclient TouchpadOff=0
else
    synclient TouchpadOff=1
fi
