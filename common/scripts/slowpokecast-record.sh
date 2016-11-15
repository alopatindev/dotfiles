#!/bin/bash

# this script makes unique screenshots

TMPDIR="/var/tmp/vid"
SLEEP=2  # seconds between frames

FNAME="frame_"
TNAME="a.png"

#rm -rfv $TMPDIR
mkdir $TMPDIR
cd $TMPDIR

COUNT=1
if [ -f count ]; then
    COUNT=$(cat count)
fi

for ((;;)); do
    scrot -d $SLEEP $TNAME #-q 100

    skip=0
    a=$(md5sum $TNAME | awk '{print $1}')

    for f in $FNAME*.png; do
        if [ -f $f ]; then
            b=$(md5sum $f | awk '{print $1}')
            if [[ $a == $b ]]; then
                skip=1
            fi
        fi
    done

    if [[ $skip -eq 0 ]]; then
        F=$(printf "$FNAME%08d.png" $COUNT)
        echo $F
        mv $TNAME $F
        ((COUNT++))
        echo $COUNT > count
    else
        echo 'skipping'
    fi
done
