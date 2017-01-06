#!/bin/bash

REC="slowpokecast-record.sh"
P=$(ps aux | grep -v grep | grep $REC | grep '/bin/bash')

msg() {
    echo "^fg(#ffffff)^bg(#5D9457)$1" | \
        dzen2 -fn "DejaVu Sans:size=70" -p 1 -ta l -y 20
}

if [[ $P != '' ]]; then
    killall $REC
    msg "$REC STOPPED"
else
    sleep 1 && ~/scripts/$REC 2&>>/dev/null &
    msg "$REC STARTED"
fi
