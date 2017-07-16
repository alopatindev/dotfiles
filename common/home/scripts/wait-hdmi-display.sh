#!/bin/bash

#SCREEN_LEFT=DP2
#SCREEN_RIGHT=eDP1
#START_DELAY=5

#renice +19 $$ >/dev/null

#sleep $START_DELAY

OLD_DUAL="dummy"

STATUS_FILE="/sys/class/drm/card0-HDMI-A-1/status"

while [ 1 ]; do
    DUAL=$(cat ${STATUS_FILE})

    if [ "$OLD_DUAL" != "$DUAL" ]; then
        if [ "$DUAL" == "connected" ]; then
            echo 'Dual monitor setup'
            #xrandr --output $SCREEN_LEFT --auto --rotate normal --pos 0x0 --output $SCREEN_RIGHT --auto --rotate normal --below $SCREEN_LEFT
            xrandr --output HDMI1 --auto
        else
            echo 'Single monitor setup'
            #xrandr --auto
            xrandr --output HDMI1 --off
        fi

        OLD_DUAL="$DUAL"
    fi

    sleep 3s
    #inotifywait -q -e close ${STATUS_FILE}
done
