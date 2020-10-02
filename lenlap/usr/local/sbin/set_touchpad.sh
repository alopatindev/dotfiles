#!/bin/sh

LOCK=/tmp/set_touchpad.lock
TIMESTAMP=/tmp/set_touchpad.timestamp
MIN_TIME_SECS=3 # between two connect/disconnect events

sleep 1

if mkdir ${LOCK}; then
    T0=$(cat ${TIMESTAMP} || echo 0)
    T1=$(date +%s)
    if [[ $((${T1}-${T0})) -gt ${MIN_TIME_SECS} ]]; then
        echo "${T1}" > "${TIMESTAMP}"
        su al -c /usr/local/bin/set_touchpad.sh
    fi
    rm -r "${LOCK}"
fi
