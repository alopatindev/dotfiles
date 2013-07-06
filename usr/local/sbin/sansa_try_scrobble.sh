#!/bin/bash

LASTFM_LOGIN=""
LASTFM_PASSWORD=""
PLAYER_MOUNTPOINT="/media/CLIP_PLUS"
SCRIPT_PATH="/root/git/Laspyt/laspyt.py"
PROMPT="$0: ${PLAYER_MOUNTPOINT}"

logger "${PROMPT} trying to scrobble"
sleep 10s

## save config only
#python3 "$SCRIPT_PATH" -sc -f "$PLAYER_MOUNTPOINT/.scrobbler.log" -t +4 -u "$LASTFM_LOGIN" -p "$LASTFM_PASSWORD"

python3 "$SCRIPT_PATH" -cb
EXIT_STATUS=$?

umount "$PLAYER_MOUNTPOINT"

if [[ $EXIT_STATUS -eq 0 ]]; then
    logger "${PROMPT} OK"
else
    logger "${PROMPT} FAIL"
fi
