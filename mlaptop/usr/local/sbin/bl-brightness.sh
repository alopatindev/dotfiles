#!/bin/bash

set -e

DELTA=""

case $1 in
    up)
        DELTA=" + 0.5"
        ;;
    down)
        DELTA=" - 0.5"
        ;;
    *)
        echo "syntax $0 [up | down]"
        exit 1
        ;;
esac

DISPLAY=:0 xgamma -q -gamma $(echo $(xgamma 2> /dev/stdout | cut -d' ' -f10) ${DELTA} | bc)
