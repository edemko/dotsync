#!/bin/sh

xinitrc="${HOME}/.xinitrc"
xinitrc_src="${dotdir}/xinitrc"

xinputrc="${HOME}/.xinputrc"
xinputrc_src="${dotdir}/xinputrc"

modmap="${HOME}/.Xmodmap"
if setxkbmap -query | grep -qi 'model:\s*macbook'; then
    modmap_src="${dotdir}/Xmodmap-macbook"
else
    modmap_src="${dotdir}/Xmodmap"
fi

compose="${HOME}/.XCompose"
compose_src="${dotdir}/XCompose"
composedir="${HOME}/.XCompose.d"
composedir_src="${dotdir}/XCompose.d"


dotsync_depsgood() {
    if ! im-config -l | grep -q '\buim\b'; then
        echo >&2 "$(withaf f80 '[WARNING]') uim is not installed"
        return 1
    fi
    if which runghc >/dev/null && which m4 >/dev/null; then
        echo >&2 "Building XCompose afresh…"
        "${1}/build/XCompose.sh"
        echo >&2 "freshened up."
    fi
    return 0
}

dotsync_newest() {
    diff -q 2>/dev/null "${xinitrc_src}" "${xinitrc}" || return 1
    diff -q 2>/dev/null "${xinputrc_src}" "${xinputrc}" || return 1
    diff -q 2>/dev/null "${modmap_src}" "${modmap}" || return 1
    diff -q 2>/dev/null "${compose_src}" "${compose}" || return 1
    # TODO diff the contents of XCompose.d
}

dotsync_setup() {
    ln -sTvf "${composedir_src}" "${composedir}"
    ln -svf "${compose_src}" "${compose}"
    ln -svf "${modmap_src}" "${modmap}"
    ln -svf "${xinputrc_src}" "${xinputrc}"
    ln -svf "${xinitrc_src}" "${xinitrc}"
}

dotsync_teardown() {
    if [ -L "${xinitrc}" ]; then rm -v "${xinitrc}"; fi
    if [ -L "${xinputrc}" ]; then rm -v "${xinputrc}"; fi
    if [ -L "${modmap}" ]; then rm -v "${modmap}"; fi
    if [ -L "${compose}" ]; then rm -v "${compose}"; fi
    if [ -L "${composedir}" ]; then rm -v "${composedir}"; fi
}
