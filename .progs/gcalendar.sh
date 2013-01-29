#!/bin/bash

F=/tmp/calendar.txt
F1=/tmp/calendar1.txt
L=22

touch "$F" "$F1"
chmod 600 "$F" "$F1"
(gcalcli --nc --mon --cals=owner --width=13 calw 3 > "$F1") && (cat "$F1" > "$F")
cat "$F"

N=$(wc -l "$F" | awk '{print $1}')
for ((i=${N}; i <= ${L}; i++)); do
    echo
done
