export ZSH="/home/paolo/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
  
alias ls="exa --icons --long --header"
alias ufetch="$HOME/ufetch-arch"
alias hdmi="$HOME/.config/scripts/hdmionly"
alias edp="$HOME/.config/scripts/edponly"
alias both="$HOME/.config/scripts/both"alias backup-dotfiles="$HOME/.config/scripts/backup-dotfiles"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
