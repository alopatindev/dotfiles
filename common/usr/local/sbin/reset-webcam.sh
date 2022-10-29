#!/bin/sh

fuser /dev/video0 || usbreset $(lsusb -d 1532: | perl -nE "/\D+(\d+)\D+(\d+).+/; print qq(/dev/bus/usb/\$1/\$2)")
sleep 2
