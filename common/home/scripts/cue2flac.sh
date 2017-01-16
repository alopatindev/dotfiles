#!/bin/zsh

MUSICDIR="/nfs/router/music"

if [[ $1 == '' ]]; then
    MASK='.cue'
else
    MASK="${1}"
fi

for i in **/*.cue
do
    cue2tracks -e -C -R -c flac -o "${MUSICDIR}/%P/%D - %A/%N - %t" "$i"
done
