#!/bin/sh

stat=$(solaar show 1 2>>/dev/null | grep Battery | xargs | sed 's!, next.*!!')
[ -z "${stat}" ] && stat='is not connected'
echo "Touchpad ${stat}"
