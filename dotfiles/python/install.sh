src="${1}/pythonrc.py"
target="${HOME}/.pythonrc"

profiledir="${HOME}/.profile.d"
profile="${profiledir}/python.sh"
profile_src="${1}/profile.d/python.sh"

dotsync_depsgood() {
    [ -d "${profiledir}" ]
}

dotsync_newest() {
    diff -q "${target}" "${src}" || return 1
    diff -q "${profile}" "${profile_src}" || return 1
}

dotsync_setup() {
    ln -srv "${src}" "${target}"
    ln -srv "${profile_src}" "${profile}"
}

dotsync_teardown() {
    [ -L "${target}" ] && rm -v "${target}"
    [ -L "${profile}" ] && rm -v "${profile}"
    return 0
}
