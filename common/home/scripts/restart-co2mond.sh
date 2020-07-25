#!/bin/sh

DATA_DIR="/tmp/co2mond"

mkdir -p "${DATA_DIR}"
killall co2mond 2>>/dev/null
~/git-extra/co2mon/build/co2mond/co2mond -d -D "${DATA_DIR}"
