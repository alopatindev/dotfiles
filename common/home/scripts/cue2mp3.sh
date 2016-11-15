#!/bin/sh
set -e
ENCODE="cust ext=mp3 lame -b 320 - %f"
FORMAT="%n.%t"

FLACFILE=$1
CUEFILE=$2
echo $FLACFILE - $CUEFILE
if [ -z "$FLACFILE" ]; then
    echo "usage: $0 FLAC_FILE [CUE_FILE]"
    exit 1
elif [ -z "$CUEFILE" ]; then
    DIRECTORY=$(dirname "$FLACFILE")
    BASENAME=$(basename "$FLACFILE" ".flac")
    CUEFILE="$DIRECTORY/$BASENAME.cue"
fi

shnsplit -O always -o "$ENCODE" -f "$CUEFILE" -t "$FORMAT" "$FLACFILE"
