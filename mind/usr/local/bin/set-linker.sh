#!/bin/sh

BINUTILS_DIR=$(ls -d1 /usr/$(uname -m)*linux-gnu)
TARGET="${BINUTILS_DIR}/bin/ld"

if [ $1 = lld ]; then
    ln -sf /usr/bin/lld "${TARGET}"
elif [ $1 = ld ]; then
    BINUTILS_VERSION_DIR=$(dirname $(readlink -f ${BINUTILS_DIR}/bin/as))
    ln -sf "${BINUTILS_VERSION_DIR}/ld" "${TARGET}"
fi
