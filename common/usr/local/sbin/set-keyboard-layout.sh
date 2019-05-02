#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/al/.Xauthority

setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:rwin
