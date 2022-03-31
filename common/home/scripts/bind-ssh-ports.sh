#!/bin/bash

if [ $# -lt 1 ]; then
    echo "syntax: $0 host-to-connect [forward-to-port-prefix]"
    exit 1
fi

SOURCE="$1"
FORWARD_TO_PORT_PREFIX="$2"

FORWARD_TO_IPS=( "127.0.0.1" )
PORTS=( "8889" "9050" "9051" )

autossh -M 0 "${SOURCE}" $(
    for ip in "${FORWARD_TO_IPS[@]}"; do
        for port in "${PORTS[@]}"; do
            echo -n " -L ${ip}:${FORWARD_TO_PORT_PREFIX}${port}:127.0.0.1:${port}"
        done
    done
)
