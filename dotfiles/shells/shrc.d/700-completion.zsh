#!/bin/zsh

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

unsetopt automenu
unsetopt menucomplete
setopt nomatch
