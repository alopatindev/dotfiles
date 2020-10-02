#!/bin/bash

PORT="HDMI1"
INIT_TIME_SECS=14

if [[ $(cat /sys/class/drm/*HDMI*/status) = 'connected' ]]; then
    logger "${PORT} connected"
    sleep "${INIT_TIME_SECS}"
    #xrandr --output eDP1 --primary --mode 1920x1080_119.94 --pos 0x0 --rotate normal --output "${PORT}" --mode 3440x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
    xrandr --output eDP1 --off --output "${PORT}" --primary --mode 3440x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
else
    logger "${PORT} disconnected"
    #xrandr --output HDMI1 --off
    xrandr --output eDP1 --primary --mode 1920x1080_119.94 --pos 0x0 --rotate normal --output HDMI1 --off
fi

su al -c "echo 'awesome.restart()' | awesome-client"
