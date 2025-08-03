#!/bin/bash
set -e

echo "Restoring packages using package-manager-backup/restore-packages.sh..."

if [[ ! -x package-manager-backup/restore-packages.sh ]]; then
  echo "Error: restore-packages.sh not found or not executable!"
  exit 1
fi

./package-manager-backup/restore-packages.sh

echo
echo "Running stow on all directories except package-manager-backup..."

for dir in */; do
  dir=${dir%/}
  if [[ "$dir" != "package-manager-backup" ]]; then
    echo "Stowing $dir..."
    stow "$dir"
  fi
done

echo
echo "Installing Oh My Zsh if not already installed..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Install Oh My Zsh unattended
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

echo
echo "Bootstrap complete!"

