UN=$(who | grep $USER | wc -l)
if [[ "${UN}" -le "1" ]]
then
    (sleep 10 && sudo fusermount -u "$HOME/.private" 2&>> /dev/null) &
fi
