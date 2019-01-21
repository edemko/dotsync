xinitrc="${HOME}/.xinitrc"
xinitrc_src="${1}/xinitrc"

modmap="${HOME}/.Xmodmap"
if setxkbmap -query | grep -qi 'model:\s*macbook'; then
    modmap_src="${1}/Xmodmap-macbook"
else
    modmap_src="${1}/Xmodmap"
fi

compose="${HOME}/.XCompose"
compose_src="${1}/XCompose"
composedir="${HOME}/.XCompose.d"
composedir_src="${1}/XCompose.d"


dotsync_depsgood() {
    # FIXME check for the right input methods (somethingsomething `uim`)
    if which runghc && which m4; then
        echo >&2 "Building XCompose afresh…"
        "${1}/build/XCompose.sh"
        echo >&2 "done."
    fi
    return 0
}

dotsync_newest() {
    diff -q "${xinitrc_src}" "${xinitrc}" || return 1
    diff -q "${modmap_src}" "${modmap}" || return 1
    diff -q "${compose_src}" "${compose}" || return 1
    # TODO diff the contents of XCompose.d
}

dotsync_setup() {
    ln -sv "${composedir_src}" "${composedir}"
    ln -sv "${compose_src}" "${compose}"
    ln -sv "${modmap_src}" "${modmap}"
    ln -sv "${xinitrc_src}" "${xinitrc}"
}

dotsync_teardown() {
    if [ -L "${xinitrc}" ]; then rm -v "${xinitrc}"; fi
    if [ -L "${modmap}" ]; then rm -v "${modmap}"; fi
    if [ -L "${compose}" ]; then rm -v "${compose}"; fi
    if [ -L "${composedir}" ]; then rm -v "${composedir}"; fi
}
