#!/bin/bash

sleep 1
logger "switch soundcard"

cd /etc/alsa/conf.d

lsusb | grep 'Xonar U3 sound card'
if [ $? = 0 ]; then
    logger "usb connected"
    device=usb
else
    logger "usb NOT connected"
    device=default
fi

device_conf="output_to_all_cards.${device}.txt"
target="99-output_to_all_cards.conf"

realpath ${target} | grep ${device_conf}
if [ $? != 0 ]; then
    ln -sf ${device_conf} ${target}
    logger "switched sound output to ${device}"
    /etc/init.d/mpd restart
fi
