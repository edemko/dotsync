vimrc="${HOME}/.vimrc"
vimrc_src="${1}/vimrc.vim"

vimdir="${HOME}/.vim"
bundledir="${vimdir}/bundle"


dotsync_depsgood() { return 0; }

dotsync_newest() {
    diff -q 2>/dev/null "${vimrc}" "${vimrc_src}" || return 1

    [ -d "${vimdir}/autoload" ] || return 1
    [ -d "${vimdir}/bundle" ] || return 1

    [ -d "${bundledir}/vim-repeat" ] || return 1
    [ -d "${bundledir}/vim-surround" ] || return 1

    return 1 # FIXME I don't know how to sync over the net with this framework
}

dotsync_setup() {
    ln -svf "${vimrc_src}" "${vimrc}"

    mkdir -p "${vimdir}/autoload" "${vimdir}/bundle"
    echo >&2 'D/LING: https://tpo.pe/pathogen.vim'
    curl -LS -o "${vimdir}/autoload/pathogen.vim" 'https://tpo.pe/pathogen.vim'

    [ -d "${bundledir}/vim-repeat" ] || git clone 'https://tpope.io/vim-repeat.git' "${bundledir}/vim-repeat"
    (cd "${bundledir}/vim-repeat" && git pull)
    [ -d "${bundledir}/vim-surround" ] || git clone 'https://tpope.io/vim/surround.git' "${bundledir}/vim-surround"
    (cd "${bundledir}/vim-surround" && git pull)
}

dotsync_teardown() {
    [ -L "${vimrc}" ] && rm -v "${vimrc}"
    return 0
}
