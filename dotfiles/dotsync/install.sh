#!/bin/sh

srcexe="${dotdir}/dotsync"
srcfuncs="${dotdir}/dotfuncs"
bindir="${HOME}/bin"
targetexe="${bindir}/dotsync"
targetfuncs="${bindir}/dotfuncs"

dotsync_depsgood() { return 0 ; }
dotsync_newest() {
    [ -x "${targetexe}" ] && [ -f "${targetfuncs}" ]
}
dotsync_setup() {
    [ -d "${bindir}" ] || mkdir -v "${bindir}"
    ln -svf "${srcexe}" "${targetexe}"
    ln -svf "${srcfuncs}" "${targetfuncs}"
}
dotsync_teardown() {
    [ -L "${targetexe}" ] && rm -v "${targetexe}"
    [ -L "${targetfuncs}" ] && rm -v "${targetfuncs}"
    return 0
}
