#!/bin/bash

# shows movies' length in human-readable format using mplayer

human_len () {
    HH=$(echo "$1 / 3600" | bc)
    MM=$(echo "($1 - $HH*3600) / 60" | bc)
    SS=$(echo "$1 - $HH*3600 - $MM*60" | bc)
    printf '%02d:%02d:%02.02f' $HH $MM $SS
}

total=0
for i in "$@"; do
    LEN=$(mplayer -vo null -ao null -frames 0 -identify "${i}" 2>>/dev/null \
        | grep ID_LENGTH | sed 's/ID_LENGTH=//')

    human_len $LEN
    echo " $i"
    total=$(echo "$total + $LEN" | bc)
done

echo
echo -n 'Total:  '
human_len $total
echo
