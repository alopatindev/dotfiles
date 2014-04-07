#!/bin/bash

YA_PATH="/webdav/ya"
LOCK_FILE="${YA_PATH}/.downloads-lock"

log() {
    echo "$1"
    logger "$1"
}

if [[ "$1" == "-u" ]]; then
    if [[ -f "${LOCK_FILE}" ]]; then
        set -e
        fusermount -u "${YA_PATH}/downloads"
        rm -f "${LOCK_FILE}"
        log "unmounted downloads"
    else
        log "$0: unmount failed: not locked"
    fi
else
    if [[ ! -f "${LOCK_FILE}" ]]; then
        set -e
        encfs "${YA_PATH}/.downloads-encrypted" "${YA_PATH}/downloads" -- -o nonempty
        touch "${LOCK_FILE}"
        log "mounted downloads"
    else
        log "$0: mount failed: locked"
    fi
fi

set +e
