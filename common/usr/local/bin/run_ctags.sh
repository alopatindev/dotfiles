#!/bin/bash

current_dir=$(pwd)
while [[ "$current_dir" != "/" ]]; do
    if [ -e "$current_dir/tags" ]; then
        logger "tags were found in $current_dir"
        exit 0
    fi
    current_dir=$(dirname "$current_dir")
done

logger "running ctags in $(pwd) ..."
touch tags
chown "${SUDO_USER}:${SUDO_USER}" tags
su "${SUDO_USER}" --command='ctags -R .'
logger "running ctags in $(pwd) done"
