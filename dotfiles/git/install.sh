dotsync_depsgood() {
    return 0
}

dotsync_newest() {
    git config --global --get core.editor >/dev/null || return 1
    git config --global --get user.name >/dev/null || return 1
    git config --global --get user.email >/dev/null || return 1
    # Aliases
    git config --global --get alias.st >/dev/null || return 1
    git config --global --get alias.graph >/dev/null || return 1
    git config --global --get alias.com >/dev/null || return 1
    git config --global --get alias.amend >/dev/null || return 1
    git config --global --get alias.co >/dev/null || return 1
    git config --global --get alias.rollback >/dev/null || return 1
    git config --global --get alias.unstage >/dev/null || return 1
}

dotsync_setup() {
    local inp
    git config --global core.editor vim
    if ! git config --global --get user.name >/dev/null; then
        echo >&2 "$(withaf d0f '[NOTICE]') Global git user.name not set; who are you [skip]: "
        read inp
        case "${inp}" in
            '') ;;
            * ) git config --global user.name "${inp}" ;;
        esac
    fi
    if ! git config --global --get user.email >/dev/null; then
        echo >&2 "$(withaf d0f '[NOTICE]') Global git user.email not set; what's your email [skip]: "
        read inp
        case "${inp}" in
            '') ;;
            * ) git config --global user.email "${inp}" ;;
        esac
    fi
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
