#!/bin/bash

IFACE=wlan0

(sudo /sbin/ifconfig ${IFACE} | grep UP >> /dev/null) || \
    sudo ifconfig ${IFACE} up || exit 1

sudo /sbin/iwlist wlan0 scan \
    | egrep -i '(encr|essid|quali)' \
    | sed 's/^ *//g;s/^Quality/\nQuality/g'
