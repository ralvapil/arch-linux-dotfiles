#!/usr/bin/env bash

if pgrep -x swayidle >/dev/null; then
    if ps -o stat= -C swayidle | grep -q T; then
        # Currently stopped → resume
        pkill -CONT swayidle
        notify-send "Swayidle enabled"
    else
        # Currently running → pause
        pkill -STOP swayidle
        notify-send "Swayidle disabled"
    fi
else
    notify-send "Swayidle not running"
fi

