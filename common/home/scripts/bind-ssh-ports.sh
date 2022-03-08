#!/bin/bash

SOURCE="vsmall"
FORWARD_TO_IPS=( "127.0.0.1" )
PORTS=( "8889" "9050" "9051" )

autossh -M 0 "${SOURCE}" $(
    for ip in "${FORWARD_TO_IPS[@]}"; do
        for port in "${PORTS[@]}"; do
            echo -n " -L ${ip}:${port}:127.0.0.1:${port}"
        done
    done
)
