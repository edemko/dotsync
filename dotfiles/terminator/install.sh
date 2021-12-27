#!/bin/sh

target="${HOME}/.config/terminator/config"
src="${dotdir}/config"

dotsync_depsgood() {
    if ! which terminator >/dev/null; then
        return 1
    fi
    if ! (fc-list | grep -q 'Eexpr Reference Mono'); then
        echo >&2 "$(withaf f80 '[WARNING]') Eexpr Reference Mono not installed."
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
