# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# sudo not required for some system commands
for command in mount umount sv updatedb su shutdown poweroff reboot ; do
	alias $command="sudo $command"
done; unset command

# Verbosity and settings that you pretty much just always are going to want.
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	bc="bc -ql" \
	mkdir="mkdir -pv" \
	yt="youtube-dl --add-metadata -i" \
	yta="yt -x -f bestaudio/best" \
	ffmpeg="ffmpeg -hide_banner"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# VI Mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use ranger to switch directories and bind it to ctrl-o
rangercd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"                                               
    fi
}
bindkey -s '^o' 'rangercd\n'

# Small letters will match small and capital letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

alias cat="bat"
alias ls="eza --long --header"
alias la="ls -a"
alias v="nvim"

alias fetch="fastfetch"

# Gentoo
alias update-system="sudo emerge --sync && sudo emerge -auDN @world"
alias update-world="sudo emerge -uDNqa --keep-going @world"
alias clean-system="sudo emerge --ask --depclean"
alias edit-make="sudoedit /etc/portage/make.conf"

alias packettracer="QT_QPA_PLATFORM=xcb ~/PacketTracer/opt/pt/packettracer.AppImage"

vbox() {
  local action=$1
  local target=$2
  local vm_name=""

  # 1. Map short nicknames to actual VirtualBox VM names (Handles the space in vms here)
  case "$target" in
    "deb"|"debian") 
      vm_name="Debian" 
      ;;
    "win"|"windows") 
      vm_name="Windows 11" 
      ;; 
    *) 
      vm_name="$target" # Fallback: use the input directly 
      ;;
  esac

  # 2. Check if the user provided a VM name (unless they are just listing)
  if [[ -z "$vm_name" && "$action" != "list" ]]; then
    echo "Error: Please specify a VM (e.g., vbox start win)"
    return 1
  fi

  # 3. Actions (Notice the quotes around "$vm_name" - these are vital!)
  case "$action" in
    "start")
      echo "Launching $vm_name in headless mode..."
      VBoxManage startvm "$vm_name" --type headless
      ;;
    "stop")
      echo "Powering off $vm_name..."
      VBoxManage controlvm "$vm_name" acpipowerbutton # Graceful Shutdown
      ;;
    "pause")
      VBoxManage controlvm "$vm_name" pause
      ;;
    "resume")
      VBoxManage controlvm "$vm_name" resume
      ;;
    "status")
      VBoxManage showvminfo "$vm_name" | grep -E "State:|Name:"
      ;;
    "list")
      echo "--- All Configured VMs ---"
      VBoxManage list vms
      echo -e "\n--- Currently Running ---"
      VBoxManage list runningvms
      ;;
    *)
      echo "Usage: vbox {start|stop|pause|resume|status|list} {deb|win}"
      echo "Example: vbox start deb"
      ;;
  esac
}

compctl -k "(start stop pause resume status list)" vbox # Tab Completion

# Define o Neovim como editor padrão para o sistema e sudoedit
export EDITOR="nvim"
export VISUAL="nvim"
