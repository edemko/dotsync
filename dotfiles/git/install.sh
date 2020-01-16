sqliterc="${HOME}/.sqliterc"
sqliterc_src="${1}/sqliterc"


dotsync_depsgood() {
    return 0
}

dotsync_newest() {
    git config --global --get core.editor || return 1
    # Aliases
    git config --global --get alias.st || return 1
    git config --global --get alias.graph || return 1
    git config --global --get alias.com || return 1
    git config --global --get alias.amend || return 1
    git config --global --get alias.co || return 1
    git config --global --get alias.rollback || return 1
    git config --global --get alias.unstage || return 1
}

dotsync_setup() {
    git config --global core.editor vim
    # Aliases
    git config --global alias.st 'status'
    git config --global alias.graph 'log --graph --all --oneline --decorate'
    git config --global alias.com 'commit -a'
    git config --global alias.amend 'commit -a --amend'
    git config --global alias.co 'checkout'
    git config --global alias.rollback 'checkout --'
    git config --global alias.unstage 'reset --'
}

dotsync_teardown() {
    return 0
}
