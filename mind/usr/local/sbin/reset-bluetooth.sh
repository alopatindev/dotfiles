#!/bin/bash

# /etc/init.d/rpi3-bluetooth restart
# or: btattach -B /dev/ttyAMA0 -P bcm -S 921600 -N

hcitool cmd 0x3f 0x001 0x01 0x22 0x54 0x44 0x22 0x01
hciconfig hci0 reset
/etc/init.d/bluetooth restart
/etc/init.d/bluealsa restart
