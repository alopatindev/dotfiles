#!/bin/bash

MUSICDIR="/nfs/router/music"
#MUSICDIR='/home/music/_router'

if [[ $1 == '' ]]; then
    MASK='.cue'
else
    MASK="${1}"
fi

#for i in *.wv.cue *.flac.cue */*.flac.cue
for i in *.cue
#for i in $(find . -type f -iname '*.cue*')
do
    echo $i
    cue2tracks -R -c flac -o "${MUSICDIR}/%P/%D - %A/%N - %t" "$i"
done

##find -iname "*${MASK}" -type f -print0 \
##    | xargs -0 cue2tracks -c flac -o "${MUSICDIR}/%P/%D - %A/%N - %t" "${i}"
