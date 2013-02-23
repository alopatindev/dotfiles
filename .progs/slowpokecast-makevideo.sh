#!/bin/bash

set -e

TMPDIR="/var/tmp/vid"
FNAME="frame_"
OUT="a.flv"

if [[ $1 == '' ]]; then
    echo "syntax $0 [music.ogg]"
    exit 1
fi

cd $TMPDIR
FNUMBER=$(ls -1 $FNAME*.png | wc -l)

if [[ $1 == '' ]]; then
    ffmpeg -v quiet -i $FNAME%08d.png -vcodec flv -r 30 -sameq $OUT
else
    LEN=$(mplayer -vo null -ao null -frames 0 -identify "$1" 2>>/dev/null | \
          grep ID_LENGTH | sed 's/ID_LENGTH=//')
    LEN=$(echo $LEN | sed 's/\.[0-9]*//')
    echo "LEN=$LEN"
    echo "FNUMBER=$FNUMBER"

    #TODO: if LEN < FNUMBER then exit with error?

    FPS=$(echo "$LEN/$FNUMBER" | bc -l)
    echo "input FPS=$FPS"
    ffmpeg -vol 200 -ab 320k -i "$1" \
    -r 1/$FPS -i $FNAME%08d.png -vcodec flv -sameq -r 30 \
    $OUT
fi
