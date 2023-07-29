#!/bin/bash

HDMI_PORT="HDMI-0"
LAPTOP_PORT="DP-4"

#HDMI_PORT="HDMI1"
#LAPTOP_PORT="eDP1"

query_mode () {
    port="$1"
    mode=$(xrandr | grep --after-context=1 "${port} connected" | tail -n1 | awk '{print $1}')
    logger "${port} mode: ${mode}"
    echo "${mode}"
}

source /etc/profile

LAPTOP_MODE=$(query_mode "${LAPTOP_PORT}")
HDMI_MODE=$(query_mode "${HDMI_PORT}")

mpc stop
/etc/init.d/mpd stop
/etc/init.d/alsasound restore

ps uax | grep 'mpv --no-terminal --loop-file=inf /usr/share/sounds/silence.flac' | grep -v grep | awk '{print $2}' | xargs kill 2>> /dev/null

if [[ $(cat /sys/class/drm/*HDMI*/status) = 'connected' ]]; then
    logger "${HDMI_PORT} connected"
    while [[ $(cat /sys/class/drm/*HDMI*/status) = 'connected' ]]; do
        logger "attempt to switch to HDMI"
        xrandr # or else it may stuck forever
        HDMI_MODE=$(query_mode "${HDMI_PORT}")
        xrandr --output "${LAPTOP_PORT}" --off --output "${HDMI_PORT}" --primary --mode "${HDMI_MODE}" --pos 0x0 --rotate normal --output VIRTUAL1 --off && break || sleep 1
    done
else
    logger "${HDMI_PORT} disconnected"
    #xrandr --output "${LAPTOP_PORT}" --auto
    xrandr --output "${LAPTOP_PORT}" --primary --mode "${LAPTOP_MODE}" --pos 0x0 --rotate normal --output "${HDMI_PORT}" --off
fi

sleep 0.3

su al --preserve-environment --command "echo 'awesome.restart()' | awesome-client ; mpv --no-terminal --loop-file=inf /usr/share/sounds/silence.flac &"

/etc/init.d/mpd restart
