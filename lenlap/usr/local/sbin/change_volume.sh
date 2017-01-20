#!/bin/bash

STEP=3

#DEV=Headphone
DEV=Master

amixer -q sset "${DEV}" "${STEP}${1}"

# vim: textwidth=0
