#!/bin/bash

v4l2-ctl --verbose --device=/dev/video0 --set-ctrl=saturation=153 --set-ctrl=gain=0
