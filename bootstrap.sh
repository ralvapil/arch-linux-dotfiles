#!/bin/bash
set -e

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

