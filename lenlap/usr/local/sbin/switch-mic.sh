#!/bin/bash

cd /etc/alsa/conf.d

lsusb | grep 'ZOOM Corporation H1n'
if [ $? = 0 ]; then
    device=zoom_mic
    text=H1n
else
    device=headset_or_internal_mic
    text=i
fi

device_conf="default.${device}.txt"
target="default.conf"

realpath ${target} | grep ${device_conf}
if [ $? != 0 ]; then
    ln -sf ${device_conf} ${target}
    logger "switched sound capture to ${device}"
    #if [[ ${text} = i ]] ; then
    #    notify-send -t 5000 "H1n disconnected" "restart apps that use mic"
    #fi
fi

echo ${text} > /tmp/.mic
