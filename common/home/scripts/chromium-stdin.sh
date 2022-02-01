#!/bin/bash

~/scripts/switch-to-tag 3
sleep 0.1

chromium "$(cat)" 1>>/dev/null 2>&1 &
