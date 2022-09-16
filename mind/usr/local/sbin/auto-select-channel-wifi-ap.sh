#!/bin/bash

AP_IFACE=$(iw dev | grep Interface | grep wlp | awk '{print $2}')

#ls -1 /etc/hostapd/auto/hostapd.conf_* | sort | grep -v $(realpath /etc/hostapd/hostapd.conf)

CONF=/etc/hostapd/hostapd.conf

current_conf=$(realpath "${CONF}")
sorted_confs=$(ls -1 /etc/hostapd/auto/hostapd.conf_* | sort)

last_conf=$(ls -1 /etc/hostapd/auto/hostapd.conf_* | sort | tail -n1)

if [[ ${current_conf} = ${last_conf} ]]; then
    first_conf=$(ls -1 /etc/hostapd/auto/hostapd.conf_* | sort | head -n1)
    next_conf=${first_conf}
else
    next_conf=$(echo "$sorted_confs" | awk -v current="$current_conf" '
        BEGIN { found = 0 }
        {
            if (found == 1) {
                print $0
                exit
            }
            if ($0 == current) {
                found = 1
            }
        }
        END {
            if (found == 0) {
                print $1
            }
        }
    ')
fi

ls -l "${CONF}"
ln -sf "${next_conf}" "${CONF}"
ls -l "${CONF}"

ln -sf /etc/init.d/net.lo /etc/init.d/net.${AP_IFACE}

sed -i 's!^interface=.*$!interface='${AP_IFACE}'!g' $(realpath "${CONF}")
sed -i 's!^DHCPD_IFACE=.*$!DHCPD_IFACE="'${AP_IFACE}'"!g' /etc/conf.d/dhcpd
sed -i 's!^rc_need=.*$!rc_need="net.'${AP_IFACE}'"!g' /etc/conf.d/sshd
sed -i 's!^INTERFACES=.*$!INTERFACES="'${AP_IFACE}'"!g' /etc/conf.d/hostapd


sleep 3
/etc/init.d/hostapd restart

/etc/init.d/net.${AP_IFACE} start
/etc/init.d/dhcpd start
/etc/init.d/sshd start

echo "${current_conf} => ${next_conf}"
