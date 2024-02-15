#!/bin/bash

AP_IFACE=$(iw dev | grep Interface | grep wlp | awk '{print $2}')

/etc/init.d/hostapd stop
for i in /etc/init.d/net.wlp* ; do "$i" stop ; done
rmmod 8821au
modprobe 8821au

rm -fv /etc/init.d/net.wlp*
ln -sf /etc/init.d/net.lo /etc/init.d/net.${AP_IFACE}


sed -i 's!^interface=.*$!interface='${AP_IFACE}'!g' $(realpath /etc/hostapd/hostapd.conf)
sed -i 's!^DHCPD_IFACE=.*$!DHCPD_IFACE="'${AP_IFACE}'"!g' /etc/conf.d/dhcpd
sed -i 's!^rc_need=.*$!rc_need="net.'${AP_IFACE}'"!g' /etc/conf.d/sshd
sed -i 's!^INTERFACES=.*$!INTERFACES="'${AP_IFACE}'"!g' /etc/conf.d/hostapd

/etc/init.d/net.${AP_IFACE} restart
/etc/init.d/dhcpd restart
/etc/init.d/sshd restart
/etc/init.d/hostapd restart

sleep 3
/etc/init.d/dhcpd restart
/etc/init.d/mpd start
