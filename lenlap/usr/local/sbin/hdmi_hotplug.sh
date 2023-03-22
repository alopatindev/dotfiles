#!/bin/bash

PORT="HDMI1"

sudo /etc/init.d/alsasound restore

if [[ $(cat /sys/class/drm/*HDMI*/status) = 'connected' ]]; then
    logger "${PORT} connected"
    while [[ $(cat /sys/class/drm/*HDMI*/status) = 'connected' ]]; do
        logger "attempt to switch to HDMI"
        xrandr # or else it may stuck forever
        #xrandr --output eDP1 --off --output "${PORT}" --primary --mode 3440x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off && break || sleep 1
        xrandr --output eDP1 --off --output "${PORT}" --primary --mode 4096x2160 --pos 0x0 --rotate normal --output VIRTUAL1 --off && break || sleep 1
        #xrandr --output eDP1 --off --output "${PORT}" --primary --mode --auto --pos 0x0 --rotate normal --output VIRTUAL1 --off && break || sleep 1
    done
else
    logger "${PORT} disconnected"
    #xrandr --output eDP1 --auto
    #xrandr --output eDP1 --primary --mode 1920x1080_119.94 --pos 0x0 --rotate normal --output HDMI1 --off
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off
fi

su al -c "echo 'awesome.restart()' | awesome-client"
