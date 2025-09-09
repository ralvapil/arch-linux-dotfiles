export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

export DXVK_CONFIG_FILE=/home/ram/.config/dxvk.conf

alias e=eza
alias v=nvim
alias z=zellij -l welcome
alias lg=lazygit
alias img='swayimg --slideshow'
alias cat=bat

alias waybar-reload='pkill waybar && niri msg action spawn -- waybar'

# Find orphan packages and remove them
alias pm-remove-orphas='pacman -Qdtq | pacman -Rns -'

# From rate-mirrors to pull the latest and fastest mirror information
alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
# alias ua-update-all='
#   PRE_ID=$(sudo snapper -c root create -t pre -p | awk '"'"'{print $NF}'"'"') && \
#   export TMPFILE="$(mktemp)" && \
#   sudo true && \
#   rate-mirrors --save=$TMPFILE arch --max-delay=21600 && \
#   sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup && \
#   sudo mv $TMPFILE /etc/pacman.d/mirrorlist && \
#   ua-drop-caches && \
#   yay -Syyu --noconfirm && \
#   sudo snapper -c root create -t post --pre-number "$PRE_ID"
# '

eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

source $ZSH/oh-my-zsh.sh

# Enable autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

# MUST be placed at the end else it doesnt work
bindkey '^R' fzf-history-widget
