#!/bin/bash

cd /c/Users/imato/drss || exit 1

if [ ! -f selected.txt ]; then
    echo "[$(date)] selected.txt missing" >> cron_error.log
    exit 1
fi

PLAYBACK_TARGET=$(cat selected.txt)

if [ ! -f "$PLAYBACK_TARGET" ]; then
    echo "[$(date)] Missing file: $PLAYBACK_TARGET" >> cron_error.log
    exit 1
fi

"/c/Program Files/VideoLAN/VLC/vlc.exe" \
-I dummy \
--play-and-exit \
"$PLAYBACK_TARGET"

echo "[$(date)] Played: $PLAYBACK_TARGET" >> history.log