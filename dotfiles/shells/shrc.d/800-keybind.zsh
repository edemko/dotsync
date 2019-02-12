# FIXME do I want vi, or just stick with emacs?
bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^R' history-incremental-search-backward
setopt ignoreeof
