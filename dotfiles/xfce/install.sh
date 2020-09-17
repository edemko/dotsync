#!/bin/sh

src="${dotdir}/src"
target="${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml"
bakup="${target}.bak"

dotsync_depsgood() {
}

dotsync_newest() {
    [ -d "$target" -a -L "$target" ] || return 1
}

dotsync_setup() {
    if [ -d "$target" -a ! -L "$target" ]; then
        echo >&2 "$(withaf d0f '[NOTICE]') creating back-up of '${target}' at '${backup}'"
        mv "${target}" "${backup}"
    fi
    ln -svf "${src}" "${target}"
}

dotsync_teardown() {
    [ -L "$target" ] && rm "$target"
    [ -d "$backup" ] && mv "$backup" "$target"
    return 0
}
