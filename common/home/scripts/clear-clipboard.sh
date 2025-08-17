#!/bin/bash

killall autocutsel
for i in primary secondary clipboard buffer-cut ; do
    echo -n '_' | xclip -in -selection "$i"
done
autocutsel -selection CLIPBOARD -fork
