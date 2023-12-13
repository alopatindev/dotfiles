#!/bin/bash

set -e

quickpkg --include-config=y --include-unmodified-config=y @module-rebuild

cd /usr/src/linux
make -j`nproc` bzImage modules
make modules_install

mount /boot
mv -v /boot/EFI/Boot/bootx64.efi /boot/EFI/Boot/bootx64.efi.old
cp -v arch/x86/boot/bzImage /boot/EFI/Boot/bootx64.efi

# mount -o remount,rw -t efivarfs efivarfs /sys/firmware/efi/efivars
# ls -l /dev/disk/by-label/*BOOT
# efibootmgr -c -d /dev/nvme0n1 -L "Gentoo" -l '\EFI\Boot\bootx64.efi'
# efibootmgr -c -d /dev/nvme0n1 -L "Gentoo old" -l '\EFI\Boot\bootx64.efi.old'
# mount -o remount,ro -t efivarfs efivarfs /sys/firmware/efi/efivars
#
# efibootmgr -o 0,1
# efibootmgr --timeout 0
# efibootmgr --timeout 1

umount /boot

em -1 --ignore-built-slot-operator-deps=y @module-rebuild

chattr -i /forcefsck /home/forcefsck /mnt/*/forcefsck
rm -fv /forcefsck /home/forcefsck /mnt/*/forcefsck

# touch /forcefsck /home/forcefsck /mnt/lenslowssd/forcefsck ; chattr +i /forcefsck /home/forcefsck /mnt/lenslowssd/forcefsck
