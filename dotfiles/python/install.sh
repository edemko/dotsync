#!/bin/sh

src="${dotdir}/pythonrc.py"
target="${HOME}/.pythonrc"

profiledir="${HOME}/.profile.d"
profile="${profiledir}/python.sh"
profile_src="${dotdir}/profile.d/python.sh"

dotsync_depsgood() {
    [ -d "${profiledir}" ]
    # FIXME make sure pip and venv are installed
}

dotsync_newest() {
    diff -q 2>/dev/null "${target}" "${src}" || return 1
    diff -q 2>/dev/null "${profile}" "${profile_src}" || return 1
}

dotsync_setup() {
    ln -svf "${src}" "${target}"
    ln -svf "${profile_src}" "${profile}"
}

dotsync_teardown() {
    [ -L "${target}" ] && rm -v "${target}"
    [ -L "${profile}" ] && rm -v "${profile}"
    return 0
}
