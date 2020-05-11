#!/bin/sh

set -e

cd /usr/src/linux

time make -j4 Image modules dtbs
make modules_install

mount /boot
mv /boot/kernel8-p4.img /boot/kernel8-p4.img.old
mv /boot/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb.old
mv /boot/config-p4 /boot/config-p4.old

cp .config /boot/config-p4
cp arch/arm64/boot/Image /boot/kernel8-p4.img
cp arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb
