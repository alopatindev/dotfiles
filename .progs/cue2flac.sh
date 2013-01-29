#!/bin/bash

MUSICDIR="/nfs/router/music"

if [[ $1 == '' ]]; then
    MASK='.cue'
else
    MASK="${1}"
fi

for i in *.flac.cue */*.flac.cue
do
    cue2tracks -R -c flac -o "${MUSICDIR}/%P/%D - %A/%N - %t" "$i"
done

#find -iname "*${MASK}" -type f -print0 \
#    | xargs -0 cue2tracks -c flac -o "${MUSICDIR}/%P/%D - %A/%N - %t" "${i}"
