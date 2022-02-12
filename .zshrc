export ZSH="/home/paolo/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ls="exa --icons --long --header"
alias vim="nvim"
alias ufetch="$HOME/ufetch-arch"
alias backup-dotfiles="$HOME/.config/scripts/backup-dotfiles"
alias bluetooth-on="bluetoothctl power on && notify-send 'Bluetooth ON'"
alias bluetooth-off="bluetoothctl power off && notify-send 'Bluetooth OFF'"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
