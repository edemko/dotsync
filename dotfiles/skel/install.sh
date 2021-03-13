#!/bin/sh

src="${dotdir}/skelfiles"
target="${HOME}/.config/skel"


dotsync_depsgood() {
  which skel >/dev/null 2>&1 || return 1
}

dotsync_newest() {
  [ -L "$target" ] && [ "$(realpath "$target")" = "$src" ] || return 1
}

dotsync_setup() {
    ln -svf "${src}" "${target}"
}

dotsync_teardown() {
    [ -L "${target}" ] && rm -v "${target}"
    return 0
}
