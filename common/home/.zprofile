# core dumps size
ulimit -c unlimited

# open file descriptors
ulimit -n 4096

mount | egrep '^encfs on.*\.private type fuse.encfs' >> /dev/null
# mounting encrypted fs
if [[ $? -ne 0 ]]
then
    sudo encfs --public ~/.private-encrypted ~/.private --idle=120 -- -o nonempty,noatime
fi

# running X
#if [[ $TERM != screen.linux &&
#      ! $(ps uax | egrep 'X.*:0' | grep $USER | grep -v grep) ]]
ps uax | egrep 'X.*:[0-9]' | grep $USER | grep -v grep >> /dev/null
if [[ $? -ne 0 && $TERM != screen ]]
then
    echo -n '>>> X11 is not running. Run X11 (and GTFO from the shell)? [Y/n] '
    read ANSWER
    #[[ $ANSWER == n ]] || (service mydm restart ; exit)
    if [[ $ANSWER != n ]]; then
        sudo /etc/init.d/mydm restart
        exit
    fi
fi
