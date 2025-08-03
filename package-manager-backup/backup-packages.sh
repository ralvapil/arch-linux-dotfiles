#!/bin/bash
pacman -Qqe > pkglist-pacman.txt
yay -Qqe > pkglist-aur.txt
echo "Package lists saved."

