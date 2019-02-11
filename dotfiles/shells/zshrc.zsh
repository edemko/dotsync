# Safety
# setopt nounset # this messes with virtualenv's activate scripts
setopt warncreateglobal
#setopt noclobber
setopt ignoreeof
# setopt errexit # although it should always be set for non-interactive, in interactive it would be a huge pain
setopt errreturn # unlike errexit, fine for interactive shells
unsetopt multifuncdef
# setopt multios # on by default, not sure how I think about it

# Line Editing
# FIXME do I want vi, or just stick with emacs?
bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^R' history-incremental-search-backward
setopt rcquotes

# Changing Directories
unsetopt autocd
setopt autopushd
setopt pushd_ignoredups
# setopt chaselinks

# Completion
unsetopt automenu
unsetopt menucomplete
setopt nomatch

# Expansion and Globbing
# setopt numericglobsort

# History
HISTFILE=~/.zsh_histfile
HISTSIZE=1200
SAVEHIST=1000
setopt extendedhistory
setopt histexpiredupsfirst
setopt histverify
setopt incappendhistory


# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall



# Prompt Config
export PS1='%F{blue}%n@%M%f:%F{green}%B%(3~.…/.)%3~%b%f%(!.#.$) '
export RPS1='%(?.<%?>.<%F{red}%B%?%b>%f)'


# Aliases
alias ls='ls --color'
alias ll='ls -lahF'

# Path modification
export PATH="$PATH:$HOME/bin"

