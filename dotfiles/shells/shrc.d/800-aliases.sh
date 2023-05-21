#!/bin/sh

# ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias tree='tree -I ".git|dist-newstyle"'

# lolcat, but less
loless() {
    case ${#} in
        0) lolcat -f | less -R ;;
        *) lolcat -f "${1}" | less -R ;;
    esac
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ ${?} = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ln='ln -v'
# TODO an alias for relative symlinks
