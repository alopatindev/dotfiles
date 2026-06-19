#!/bin/bash

set -e

export PATH="/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"

quickpkg --include-config=y --include-unmodified-config=y @module-rebuild

cd /usr/src/linux
patch -r /dev/null -Np1 < ../patches/reg-6.6.1.patch || :
[ -f .config ] || cp ../linux_/.config .
make olddefconfig
make -j`nproc` bzImage modules
make modules_install

mount /boot
mv -v /boot/EFI/Boot/bootx64.efi /boot/EFI/Boot/bootx64.efi.old
cp -v arch/x86/boot/bzImage /boot/EFI/Boot/bootx64.efi

# mount -o remount,rw -t efivarfs efivarfs /sys/firmware/efi/efivars
# ls -l /dev/disk/by-label/*BOOT
# efibootmgr -c -d /dev/nvme0n1 -L "Gentoo" -l '\EFI\Boot\bootx64.efi'
# efibootmgr -c -d /dev/nvme0n1 -L "Gentoo old" -l '\EFI\Boot\bootx64.efi.old'
## efibootmgr -c -d /dev/nvme0n1 -L "Gentoo single mode" -l '\EFI\Boot\bootx64.efi' --unicode 'S' # kernel params seem to not supported by dell
# mount -o remount,ro -t efivarfs efivarfs /sys/firmware/efi/efivars
#
# efibootmgr -o 0,1
# efibootmgr --timeout 0
# efibootmgr --timeout 1

umount /boot

emerge -1 --ignore-built-slot-operator-deps=y @module-rebuild

emerge -1 --noreplace dev-util/nvidia-cuda-toolkit::gentoo

#chattr -i /forcefsck /home/forcefsck /mnt/*/forcefsck
#rm -fv /forcefsck /home/forcefsck /mnt/*/forcefsck

# touch {/home,/mnt/lenslowssd,}/forcefsck ; chattr +i {/home,/mnt/lenslowssd,}/forcefsck
