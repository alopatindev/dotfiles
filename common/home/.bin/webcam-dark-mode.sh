#!/bin/bash

v4l2-ctl --verbose --device=/dev/video0 --set-ctrl=saturation=92 --set-ctrl=gain=65
