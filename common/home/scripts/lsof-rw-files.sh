#!/bin/sh

# https://unix.stackexchange.com/questions/101904/lsof-show-files-open-as-read-write#comment686090_115722

sudo lsof / | awk 'NR==1 || $4~/[0-9]+[uw -]/'
