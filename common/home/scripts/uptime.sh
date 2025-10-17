#!/bin/bash

for i in media.codonaft mirror.codonaft ; do
  output=$(ssh "$i" -- uptime --pretty 2>>/dev/stdout)
  [[ "$?" -ne 0 ]] && notify-send -t 60000 "$i: $output"
  printf "%17s: %s\n" "$i" "${output}"
done
