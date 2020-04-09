#!/bin/sh

sqliterc="${HOME}/.sqliterc"
sqliterc_src="${1}/sqliterc"


dotsync_depsgood() {
    which sqlite3 >/dev/null 2>&1
}

dotsync_newest() {
    diff -q 2>/dev/null "${sqliterc}" "${sqliterc_src}" || return 1
}

dotsync_setup() {
    ln -svf "${sqliterc_src}" "${sqliterc}"
}

dotsync_teardown() {
    [ -L "${sqliterc}" ] && rm -v "${sqliterc}"
    return 0
}
