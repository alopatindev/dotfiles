#!/bin/sh

logger 'bluetooth OFF'
bluetoothctl power off

sleep 1
rmmod bluetooth
