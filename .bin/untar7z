#!/bin/bash

# tar7z.sh -- script for tar.7z decompressing
# Copyright (C) 2010 Alexander Lopatin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.

if [[ $1 == '' ]]; then
    echo "syntax: $0 [-v] filename.tar.7z"
    exit 1
fi

if [[ $1 == '-v' ]]; then
    VERBOSE=v
    F=$2
else
    F=$1
fi

7z x "$F" -so | tar -x$VERBOSE
