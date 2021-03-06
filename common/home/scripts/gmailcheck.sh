#!/bin/sh

# vim: textwidth=0

#GMUSER=
#PASSWD=
source ~/.private/googlerc

GURL="https://mail.google.com/mail/feed/atom"
INTERVAL=5
DISPLAY=:0
LOCKFILE="/tmp/.X0-lock"

unalias wget

while [ 1 -eq 1 ] ; do
    MCOUNT=$(wget -qO- --http-user=$GMUSER --http-password=$PASSWD $GURL | egrep -o '<fullcount>([0-9]*?)</fullcount>')
    MCOUNT=${MCOUNT#<*>} # strips <fullcount>
    MCOUNT=${MCOUNT%<*>} # strips </fullcount>
    if [ $MCOUNT -ne 0 ] ; then
        echo "^fg(#ffffff)^bg(#5D9457)$MCOUNT unread messages!" | dzen2 -fn "DejaVu Sans:size=70" -p 2 -ta l -y 20
    fi
    sleep "${INTERVAL}m"
done
