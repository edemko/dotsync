src="${1}/ghci"
target="${HOME}/.ghci"

dotsync_depsgood() { return 0; }

dotsync_newest() {
    diff -q 2>/dev/null "${target}" "${src}" || return 1
}

dotsync_setup() {
    ln -svf "${src}" "${target}"
    chmod go-w "${target}"
}

dotsync_teardown() {
    [ -L "${target}" ] && rm -v "${target}"
    return 0
}
