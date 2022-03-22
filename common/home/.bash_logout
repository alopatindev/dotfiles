#
# ~/.bash_logout
#
if [[ $(who | grep $USER | wc -l) -eq 1 ]]
then
    #(sleep 10 && sudo umount "$HOME/.private" 2&>> /dev/null) &
    (sleep 10 && sudo fusermount -u "${HOME}/.private" 2&>> /dev/null ; fusermount -u "${HOME}/.private-mind" 2&>> /dev/null) &
fi
