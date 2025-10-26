#!/usr/bin/env bash
# Launch a dedicated Ghostty terminal into the scratchpad at startup

# Launch Ghostty and capture its PID
ghostty -e zellij &
ghostty_pid=$!
# Wait for Ghostty window to appear (matching PID)
for i in {1..50}; do
    win_id=$(swaymsg -t get_tree \
        | jq --arg pid "$ghostty_pid" -r \
        '.. | select(.app_id? == "com.mitchellh.ghostty" and (.pid|tostring == $pid)) | .id' \
        | head -n 1)
    if [ -n "$win_id" ]; then
        break
    fi
    sleep 0.2
done

# If found, move it, float it, resize, and hide it
if [ -n "$win_id" ]; then
    # Move to scratchpad
    swaymsg "[con_id=$win_id]" move scratchpad

    # Temporarily show it so we can modify it
    swaymsg "[con_id=$win_id]" scratchpad show
    sleep 0.2

    # Make it float
    swaymsg "[con_id=$win_id]" floating enable

    swaymsg "[con_id=$win_id]" move position center

    # Resize and center (adjust size here)
    swaymsg "[con_id=$win_id]" resize set 60ppt 80ppt


    # Hide it back
    swaymsg "[con_id=$win_id]" scratchpad show
fi

