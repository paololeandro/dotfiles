# Initializes the encapsulated Sway in the D-Bus if it is in TTY 1.
if [[ -z "$DISPLAY" && "$TTY" == "/dev/tty1" ]]; then
    # General variables of the graphic system
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway

    # Compatibility of specific toolkits and applications 
    export MOZ_ENABLE_WAYLAND=1
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORM=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1

    exec dbus-run-session sway
fi

# Default Programs
export EDITOR="nvim"
export TERMINAL="foot"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"
