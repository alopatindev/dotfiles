#!/bin/bash

#wpa_cli select_network $(wpa_cli list_networks | grep -E '^[0-9]' | grep -v CURRENT | cut -f 1 | head -n1)
/etc/init.d/net.wlp147s0 restart
