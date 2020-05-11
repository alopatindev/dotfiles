#!/bin/sh

set -e

mount /boot

# https://github.com/raspberrypi/tools
#cd ~al/git-extra/rpi-tools/armstubs
#make -j4 CC8=aarch64-unknown-linux-gnu-gcc LD8=aarch64-unknown-linux-gnu-ld OBJCOPY8=aarch64-unknown-linux-gnu-objcopy OBJDUMP8=aarch64-unknown-linux-gnu-objdump armstub8-gic.bin

# https://github.com/raspberrypi/linux branch rpi-4.19.y
cd /usr/src/linux

time make -j4 Image modules dtbs
make modules_install

mv /boot/config-p4 /boot/config-p4.old
mv /boot/kernel8-p4.img /boot/kernel8-p4.img.old
mv /boot/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb.old
#mv /boot/armstub8-gic.bin /boot/armstub8-gic.bin.old

cp .config /boot/config-p4
cp arch/arm64/boot/Image /boot/kernel8-p4.img
cp arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb
#cp ~al/git-extra/rpi-tools/armstubs/armstub8-gic.bin /boot/armstub8-gic.bin
