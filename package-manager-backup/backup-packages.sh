#!/bin/bash
#!/usr/bin/env bash
set -euo pipefail

# Explicit repo packages only
comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort) > pkglist-pacman.txt

# Explicit AUR/foreign packages only
pacman -Qqm > pkglist-aur.txt

echo "Repo packages : $(wc -l < pkglist-pacman.txt)"
echo "AUR packages  : $(wc -l < pkglist-aur.txt)"
