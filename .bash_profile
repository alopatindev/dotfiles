#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ $TERM != screen.linux &&
      ! $(ps uax | egrep 'X.*:0' | grep $USER | grep -v grep) ]]
then
    echo -n '>>> X11 is not running. Run X11 (and GTFO from the shell)? [Y/n] '
    read ANSWER
    #[[ $ANSWER == n ]] || (service mydm restart ; exit)
    if [[ $ANSWER != n ]]; then
        service mydm restart
        exit
    fi
fi
