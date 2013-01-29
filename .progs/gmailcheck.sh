#!/bin/sh

#GMUSER=
#PASSWD=
source ~/.private/googlerc

GURL="https://mail.google.com/mail/feed/atom"
INTERVAL=5
DISPLAY=:0
LOCKFILE="/tmp/.X0-lock"

while [ 1 -eq 1 ] ; do
    MCOUNT=$(wget -qO- --http-user=$GMUSER --http-password=$PASSWD $GURL | grep fullcount)
    MCOUNT=${MCOUNT#<*>} # strips <fullcount>
    MCOUNT=${MCOUNT%<*>} # strips </fullcount>
    if [ $MCOUNT -ne 0 ] ; then
        echo "^fg(#ffffff)^bg(#5D9457)$MCOUNT unread messages!" | ~/.progs/dzen/dzen2-svn -fn "DejaVu Sans:size=50" -p 2 -ta l -y 20
    fi
    sleep $INTERVAL"m"
done
