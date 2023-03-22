#!/bin/bash

[ -z ${DEVPATH} ] && exit 1

for i in $(find "/sys${DEVPATH}" -follow -maxdepth 3 -type f -name authorized); do
    logger blocking usb "$i"
    echo 0 > "$i"
done
