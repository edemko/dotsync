#!/bin/sh

target="${HOME}/.config/terminator/config"
src="${dotdir}/config"

dotsync_depsgood() {
    if ! which terminator >/dev/null; then
        return 1
    fi
    return 0
}

dotsync_newest() {
    diff -q "${target}" "${src}" || return 1
}

dotsync_setup() {
    mkdir -p "$(dirname "$target")"
    cp "$src" "$target"
}

dotsync_teardown() {
    return 0
}
