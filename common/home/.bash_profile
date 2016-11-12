#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

ulimit -c unlimited

# mounting encrypted fs
if [[ ! $(mount | egrep '^encfs on.*\.private type fuse.encfs') ]]
then
    sudo encfs --public ~/.private-encrypted ~/.private -- -o nonempty
fi

# running X
if [[ $TERM != screen.linux &&
      ! $(ps uax | egrep 'X.*:[0-9]' | grep $USER | grep -v grep) ]]
then
    echo -n '>>> X11 is not running. Run X11 (and GTFO from the shell)? [Y/n] '
    read ANSWER
    #[[ $ANSWER == n ]] || (service mydm restart ; exit)
    if [[ $ANSWER != n ]]; then
        service mydm restart
        exit
    fi
fi
