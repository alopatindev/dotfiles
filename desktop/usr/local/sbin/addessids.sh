#!/bin/bash

IFACE=${1:-wlan0}
TMPDIR="/tmp"

IWLIST="${TMPDIR}/iwlist.${IFACE}"
iwlist "${IFACE}" scan > "${IWLIST}"
grep 'Encryption key:' "${IWLIST}" | sed 's/.*://'
grep 'ESSID:' "${IWLIST}" | sed 's/.*ESSID:\"//;s/\"//'
