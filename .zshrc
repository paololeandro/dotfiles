export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias ls="exa --icons --long --header"
alias vim="lvim"
alias backup-dotfiles="$HOME/.config/scripts/backup-dotfiles"
alias get-hex="$HOME/.config/scripts/get-hex"

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1

source /opt/asdf-vm/asdf.sh

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
