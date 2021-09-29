#!/bin/bash

/usr/local/sbin/load-webcam-settings.sh
v4l2-ctl --verbose --device=/dev/video2 --set-ctrl=saturation=85 --set-ctrl=gain=155
