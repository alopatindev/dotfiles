#!/bin/bash

for autossh_pid in $(ps uax | grep 'autossh ' | grep '\-L ' | grep -v grep | awk '{print $2}') ; do
    ps -u --ppid ${autossh_pid} | grep '/ssh ' | grep '\-L ' | grep -v grep | awk '{print $2}' | xargs kill
done
