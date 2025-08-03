# Dotfiles and Package Backup

This repository contains my Linux configuration files (dotfiles) and a backup of installed packages managed via `pacman` and `yay`. It uses GNU Stow for managing symlinks and includes scripts to backup and restore packages.

## Structure

- Each config is stored in its own folder (e.g. `nvim`, `i3`, `zellij`) with a `.config` directory inside.
- `package-manager-backup/` contains scripts and package lists for backing up and restoring installed packages.
- GNU Stow manages symlinking config files into the home directory.

## Usage

### Backup

- Update package lists:

  ```bash
  ./package-manager-backup/backup-packages.sh
  ```

- Commit any changes to the repo.

### Restore (Fresh System Setup)

1. Clone this repo:

   ```bash
   git clone git@github.com:yourusername/arch-linux-dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the bootstrap script to restore packages and config files:

   ```bash
   ./bootstrap.sh
   ```

   This will:
   - Install all `pacman` and `yay` packages from the saved package lists.
   - Symlink all configuration files into place using `stow`.

## Notes

- Make sure GNU Stow is installed:

  ```bash
  sudo pacman -S stow
  ```

- The restore script requires `yay` to be installed for AUR packages.

---

