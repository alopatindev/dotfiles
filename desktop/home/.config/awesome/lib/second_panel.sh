#!/bin/sh

set -euo pipefail
unalias -a
#set -x

WLAN_IFACE="wlp7s0"

cd ~/.config/awesome/lib/
source second_panel_utils.sh

while [ 1 ] ; do
    echo "spanelwi.text = '$(storage_widget)$(sound_widget)$(network_widget)$(mpc_widget)'" | awesome-client
    sleep 1s
done
