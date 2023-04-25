#!/bin/sh

preferences_src="${dotdir}/preferences.dconf"


dotsync_depsgood() {
    if ! which gnome-terminal >/dev/null; then
        echo >&2 "$(withaf f00 '[ERROR]') gnome-terminal is not installed"
        return 1
    fi
    if ! which dconf >/dev/null; then
        echo >&2 "$(withaf f00 '[ERROR]') dconf is not installed (apt package dconf-cli)"
        return 1
    fi
    return 0
}

dotsync_newest() {
    if ! (dconf dump /org/gnome/terminal/ | diff -q 2>/dev/null - "${preferences_src}"); then
        return 1
    fi
    return 0
}

dotsync_setup() {
    dconf load /org/gnome/terminal/ <"${preferences_src}"
    return 0
}

dotsync_teardown() {
    echo >&2 "$(withaf f80 '[WARNING]') teardown unimplemented"
    return 0
}
