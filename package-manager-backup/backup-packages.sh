#!/bin/bash
#!/usr/bin/env bash
set -euo pipefail

# Generate a list of explicitly installed official Arch packages only
# Excludes AUR (foreign) and EndeavourOS packages

output="pkglist-pacman.txt"
> "$output"

# Convert AUR packages into an array
mapfile -t aur_array < <(pacman -Qmq)

# Loop through explicitly installed packages
for pkg in $(pacman -Qqe); do
    # Skip if the package is in the AUR array
    skip=false
    for aur in "${aur_array[@]}"; do
        if [[ "$pkg" == "$aur" ]]; then
            skip=true
            break
        fi
    done
    if $skip; then
        continue
    fi

    # Exclude EndeavourOS packages by name
    if [[ "$pkg" != endeavouros* && "$pkg" != eos* ]]; then
        echo "$pkg" >> "$output"
    fi
done

echo "Clean package list saved to $output"

# Explicit AUR/foreign packages only
pacman -Qqm > pkglist-aur.txt

echo "Repo packages : $(wc -l < pkglist-pacman.txt)"
echo "AUR packages  : $(wc -l < pkglist-aur.txt)"
