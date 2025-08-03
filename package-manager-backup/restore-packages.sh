#!/bin/bash
set -e

PACMAN_LIST="pkglist-pacman.txt"
AUR_LIST="pkglist-aur.txt"

# Check if files exist
if [[ ! -f $PACMAN_LIST ]]; then
  echo "Error: $PACMAN_LIST not found!"
  exit 1
fi

if [[ ! -f $AUR_LIST ]]; then
  echo "Error: $AUR_LIST not found!"
  exit 1
fi

echo "Installing pacman packages..."
sudo pacman -Syu --needed - < "$PACMAN_LIST"

echo "Installing AUR packages with yay..."
yay -S --needed - < "$AUR_LIST"

echo "Restore complete!"

