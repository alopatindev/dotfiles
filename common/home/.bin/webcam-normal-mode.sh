#!/bin/bash

/usr/local/sbin/load-webcam-settings.sh
v4l2-ctl --verbose --device=/dev/video2 --set-ctrl=saturation=153 --set-ctrl=gain=0