#!/bin/bash

ps uax | grep '/emerge ' | grep -v grep >> /dev/null && exit 0
emaint sync --allrepos
#emerge --sync
emerge --regen
eix-update

security_updates=$(glsa-check -tp affected | grep vulnerable: | wc -l)
updates=$(emerge -pvuDN --ignore-built-slot-operator-deps=y @system @world 2>>/dev/stdout | grep -E '^Total' | tail -n1 | sed 's! (.*!!')

updates="emerge updates: Security: ${security_updates} packages, ${updates}"
logger "${updates}"
#echo "${updates}" | grep 'Total: 0 packages' >> /dev/null || {
#    su al -c "DISPLAY=:0 notify-send -u normal -t 86400000 '${updates}'"
#}

eclean distfiles

# allow certain ISP only
[[ $(curl --silent https://ipinfo.io/org) == 'AS17451 BIZNET NETWORKS' ]] || exit 1

emerge -fvuDN --ignore-built-slot-operator-deps=y @system @world
#emerge -BvuDN --ignore-built-slot-operator-deps=y @system @world
