#!/bin/bash

/usr/local/sbin/reset-webcam.sh
v4l2-ctl --verbose --device=/dev/video0 --set-ctrl=saturation=85 --set-ctrl=gain=155
