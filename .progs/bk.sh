#!/bin/bash

if [[ $1 == "" ]]
then
    echo "syntax: ${0} filemask"
    exit 1
else
    for i in ${@}
    do
        rm -rf "${i}"
        cp -vrPf "${i}" "${i}_"
    done
fi
