UN=$(who | grep $USER | wc -l)
if [[ "${UN}" -eq "1" ]]
then
    (sleep 10 && sudo umount "$HOME/.private" 2&>> /dev/null) &
fi
