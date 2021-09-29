#!/bin/bash

#PIXELFORMAT=MJPG
PIXELFORMAT=YUYV

logger 'loading uvc webcam settings'

v4l2-ctl --verbose --device=/dev/video2 --set-fmt-video=width=1920,height=1080,pixelformat=${PIXELFORMAT} --set-ctrl=exposure_auto=1 --set-ctrl=focus_auto=0 --set-ctrl=focus_absolute=331 --set-ctrl=sharpness=50 | logger
