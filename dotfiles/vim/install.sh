vimrc="${HOME}/.vimrc"
vimrc_src="${1}/vimrc.vim"

vimdir="${HOME}/.vim"
bundledir="${vimdir}/bundle"


dotsync_depsgood() {
    if ! (fc-list | grep -q 'PowerlineSymbols'); then
        echo >&2 '[WARNING] powerline fonts not installed.'
        echo >&2 '[SUGGEST] Maybe `sudo apt install fonts-powerline`?'
    fi
    return 0;
}

dotsync_newest() {
    diff -q 2>/dev/null "${vimrc}" "${vimrc_src}" || return 1

    _pathogenstat || return 1

    _gitstat "${bundledir}/vim-airline" || return 1
    _gitstat "${bundledir}/vim-fugitive" || return 1
    _gitstat "${bundledir}/vim-repeat" || return 1
    _gitstat "${bundledir}/vim-surround" || return 1

    return 0
}

dotsync_setup() {
    ln -svf "${vimrc_src}" "${vimrc}"

    if ! _pathogenstat; then
        mkdir -p "${vimdir}/autoload" "${vimdir}/bundle"
        echo >&2 'D/LING: https://tpo.pe/pathogen.vim'
        curl -LS -o "${vimdir}/autoload/pathogen.vim" 'https://tpo.pe/pathogen.vim'
    fi

    # TODO I may need to also install a powerline font
    [ -d "${bundledir}/vim-airline" ] || git clone 'https://github.com/vim-airline/vim-airline' "${bundledir}/vim-airline"
    _gitstat "${bundledir}/vim-airline" || (cd "${bundledir}/vim-airline" && git pull)
    [ -d "${bundledir}/vim-fugitive" ] || git clone 'https://github.com/tpope/vim-fugitive' "${bundledir}/vim-fugitive"
    _gitstat "${bundledir}/vim-fugitive" || (cd "${bundledir}/vim-fugitive" && git pull)
    [ -d "${bundledir}/vim-repeat" ] || git clone 'https://tpope.io/vim-repeat.git' "${bundledir}/vim-repeat"
    _gitstat "${bundledir}/vim-repeat" || (cd "${bundledir}/vim-repeat" && git pull)
    [ -d "${bundledir}/vim-surround" ] || git clone 'https://tpope.io/vim/surround.git' "${bundledir}/vim-surround"
    _gitstat "${bundledir}/vim-surround" || (cd "${bundledir}/vim-surround" && git pull)
}

dotsync_teardown() {
    [ -L "${vimrc}" ] && rm -v "${vimrc}"
    return 0
}

# Could use https://stackoverflow.com/a/54264210 for more accurate git stuff
# TODO in fact, I bet moving this function out into some utilities file would be handy
_gitstat() {
    local repodir
    repodir="${1}"
    [ -d "${repodir}" ] || return 1
    [ "$(stat -c %y "${repodir}/.git/FETCH_HEAD" | cut -f1 -d' ')" = "$(date +'%Y-%m-%d')" ] || return 1
    return 0
}

_pathogenstat() {
    [ -d "${vimdir}/autoload" ] || return 1
    [ -d "${vimdir}/bundle" ] || return 1

    [ -f "${vimdir}/autoload/pathogen.vim" ] || return 1
    [ "$(stat -c %y "${vimdir}/autoload/pathogen.vim" | cut -f1 -d' ')" = "$(date +'%Y-%m-%d')" ] || return 1
    return 0
}
