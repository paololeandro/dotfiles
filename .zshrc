export ZSH="/home/paolo/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ls="exa --icons --long --header"
alias vim="lvim"
alias ufetch="$HOME/ufetch-arch"
alias backup-dotfiles="$HOME/.config/scripts/backup-dotfiles"
alias bluetooth-on="bluetoothctl power on && notify-send 'Bluetooth ON'"
alias bluetooth-off="bluetoothctl power off && notify-send 'Bluetooth OFF'"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH

source /opt/asdf-vm/asdf.sh
