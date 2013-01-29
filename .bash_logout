#
# ~/.bash_logout
#
if [[ $(who | grep $USER | wc -l) -eq 1 ]]
then
    cd ..
    (sleep 10 &&
        (sudo fusermount -u "$HOME/.private" 2&>> /dev/null) && \
            logger 'encfs unmount ok'
    ) &
fi
