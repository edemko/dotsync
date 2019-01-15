target="${HOME}/.Xmodmap"
if setxkbmap -query | grep -qi 'model:\s*macbook'; then
    src="${1}/Xmodmap-macbook"
else
    src="${1}/Xmodmap"
fi


dotsync_depsgood() { return 0 }
# NOTE I could have dependencies for the install script as well,
# NOTE but that being non-empty would just be a smell that the install process is too complex

# exit with 0 if the current install is up to requirements, otherwise return non-zero
dotsync_newest() {
    [ -f "${target}" ] || return 1
    diff -q "${src}" "${target}"
}

dotsync_setup() {
    ln -sv "${src}" "${target}"
}

# teardown should always succeed, even if there's nothing to teardown
# that way, upgrading a version can be done merely by testing for newest, and if not,
# then a teardown will ensure a clean state for a fresh install of the new version
dotsync_teardown() {
    if [ -L "${target}" ]; then rm -v "${target}"; fi
}
