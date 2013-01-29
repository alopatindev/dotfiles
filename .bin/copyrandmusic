#!/bin/bash

# This script uploads random mp3s from router's hdd to local usb flash
# using mpd library, until we fill up a flash

TMPFILE=/var/tmp/randcopy.$$
DEST=/media/flash/

echo -n 'loading mpd data ... '
mpc listall | egrep '^_router' | egrep '\.mp3$' > $TMPFILE
ftotal=$(wc -l $TMPFILE | cut -d' ' -f1)
musicpath=$(grep 'music_directory' /etc/mpd.conf | grep -v '#' | sed 's/music_directory[ \t]*"//g;s/"$//g') 
echo 'done'

echo "copying random files to ${DEST} ... "
for (( ;; )); do
    filenum=$(expr $RANDOM % ${ftotal} + 1)
    randfile="${musicpath}/$(head -${filenum} ${TMPFILE} | tail -1)"
    cp -vn "${randfile}" "${DEST}" || break
done
rm -f "${TMPFILE}"
echo 'done'

echo -n "syncing and unmounting ${DEST} ..."
sync
umount "${DEST}"
echo 'done'

# vim: textwidth=0
