#!/bin/bash

msg () {
  printf "%17s: %s\n" "$1" "$2"
}

ping -c1 1.1.1.1 >>/dev/null || {
  echo 'NO NETWORK'
  exit
}

for i in $(grep '\.codonaft' /etc/hosts | awk '{ print $2 }') ; do
  ps uax | grep ssh: | grep "$i" | grep '\[mux\]' | grep -v grep >>/dev/null || {
    msg "$i" "is NOT connected"
    continue
  }
  output=$(ssh "$i" -- uptime --pretty 2>>/dev/stdout)
  [[ "$?" -ne 0 ]] && notify-send -t 60000 "$i: $output"
  msg "$i" "${output}"
done
