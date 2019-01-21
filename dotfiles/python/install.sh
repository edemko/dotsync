src="${1}/pythonrc.py"
target="${HOME}/.pythonrc"

dotsync_depsgood() { return 0 ; }

dotsync_newest() {
    [ -f "${target}" ] && diff -q "${target}" "${src}"
}

dotsync_setup() {
    ln -srv "${src}" "${target}"
}

dotsync_teardown() {
    [ -L "${target}" ] && rm -v "${target}"
    return 0
}
