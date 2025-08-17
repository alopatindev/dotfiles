#!/bin/sh

modprobe bluetooth
/etc/init.d/bluetooth restart

bluetoothctl power off

# https://github.com/jkulesza/usbreset
# https://marc.info/?l=linux-usb&m=121459435621262
#usbreset $(lsusb -d 0cf3: | perl -nE "/\D+(\d+)\D+(\d+).+/; print qq(/dev/bus/usb/\$1/\$2)")

logger 'bluetooth ON'
bluetoothctl power on
