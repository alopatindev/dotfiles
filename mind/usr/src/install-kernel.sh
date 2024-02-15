#!/bin/sh

set -e

# https://github.com/raspberrypi/tools
#cd ~al/git-extra/rpi-tools/armstubs
#make -j4 CC8=aarch64-unknown-linux-gnu-gcc LD8=aarch64-unknown-linux-gnu-ld OBJCOPY8=aarch64-unknown-linux-gnu-objcopy OBJDUMP8=aarch64-unknown-linux-gnu-objdump armstub8-gic.bin

# https://github.com/raspberrypi/linux branch rpi-4.19.y
cd /usr/src/linux

export KERNEL=kernel8

#make bcm2711_defconfig # https://www.raspberrypi.com/documentation/computers/linux_kernel.html

time make -j4 Image modules dtbs

mount /boot
cp -av /boot /boot.backups/boot-$(date +%Y%m%d-%H%M%S)

make modules_install dtbs_install

cp .config /boot/config-p4
cp arch/arm64/boot/Image /boot/kernel8-p4.img
cp arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb
#cp ~al/git-extra/rpi-tools/armstubs/armstub8-gic.bin /boot/armstub8-gic.bin
# TODO: cp -rv arch/arm64/boot/dts/overlays/ /boot/

#cp arch/arm64/boot/dts/broadcom/*.dtb /boot/firmware/
#cp arch/arm64/boot/dts/overlays/*.dtb* /boot/firmware/overlays/
#cp arch/arm64/boot/dts/overlays/README /boot/firmware/overlays/
#cp arch/arm64/boot/Image.gz /boot/firmware/$KERNEL.img

# TODO: ~/git-extra/8821au-20210708
