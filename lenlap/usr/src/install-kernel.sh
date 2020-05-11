#!/bin/bash

set -e

mount /boot
cd /usr/src/linux
make -j8 bzImage modules
make modules_install
mv /boot/EFI/Boot/bootx64.efi /boot/EFI/Boot/bootx64.efi.old
cp arch/x86/boot/bzImage /boot/EFI/Boot/bootx64.efi
#em app-emulation/virtualbox-modules

#efibootmgr -c -d /dev/nvme0n1 -L "Gentoo" -l '\EFI\Boot\bootx64.efi'
#efibootmgr -c -d /dev/nvme0n1 -L "Gentoo old" -l '\EFI\Boot\bootx64.efi.old'
