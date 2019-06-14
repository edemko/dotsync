psqlrc="${HOME}/.psqlrc"
psqlrc_src="${1}/psqlrc"

histdir="${HOME}/.history/psql"


dotsync_depsgood() {
    which psql >/dev/null 2>&1
}

dotsync_newest() {
    diff -q 2>/dev/null "${psqlrc}" "${psqlrc_src}" || return 1
    [ -d "${histdir}" ] || return 1
}

dotsync_setup() {
    ln -svf "${psqlrc_src}" "${psqlrc}"
    mkdir -p "${histdir}"
}

dotsync_teardown() {
    [ -L "${psqlrc}" ] && rm -v "${psqlrc}"
    return 0
}
