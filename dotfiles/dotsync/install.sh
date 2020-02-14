srcexe="${1}/dotsync"
srcfuncs="${1}/dotfuncs"
srccolors="${1}/colors.sh"
bindir="${HOME}/bin"
targetexe="${bindir}/dotsync"
targetfuncs="${bindir}/dotfuncs"
targetcolors="${bindir}/colors.sh"

dotsync_depsgood() { return 0 ; }
dotsync_newest() {
    [ -x "${targetexe}" ] && [ -f "${targetfuncs}" ] && [ -f "${targetcolors}" ]
}
dotsync_setup() {
    [ -d "${bindir}" ] || mkdir -v "${bindir}"
    ln -svf "${srcexe}" "${targetexe}"
    ln -svf "${srcfuncs}" "${targetfuncs}"
    ln -svf "${srccolors}" "${targetcolors}"
}
dotsync_teardown() {
    [ -L "${targetexe}" ] && rm -v "${targetexe}"
    [ -L "${targetfuncs}" ] && rm -v "${targetfuncs}"
    [ -L "${targetfuncs}" ] && rm -v "${targetcolors}"
    return 0
}
