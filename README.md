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
  # Remove trailing slash
  dir=${dir%/}
  if [[ "$dir" != "package-manager-backup" ]]; then
    echo "Stowing $dir..."
    stow "$dir"
  fi
done

echo
echo "Bootstrap complete!"

