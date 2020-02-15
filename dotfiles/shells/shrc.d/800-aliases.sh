
# ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# lolcat, but less
function loless() {
    # FIXME apparently, even /dev/fd/0 doesn't exist
    lolcat -f "${1:-'/dev/fd/0'}" | less -R
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ ${?} = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ln='ln -v'
# TODO an alias for relative symlinks
