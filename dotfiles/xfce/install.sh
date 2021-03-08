#!/bin/sh

srcdir="${dotdir}/src"
targetdir="${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml"
backupdir="${targetdir}.bak"
syncd_files='xfce4-desktop.xml xfce4-keyboard-shortcuts.xml xfce4-panel.xml xfwm4.xml xsettings.xml'

dotsync_depsgood() {
    return 0
}

dotsync_newest() {
    local ret=0
    for file in $syncd_files; do
        diff -q "$targetdir/$file" "$srcdir/$file" || ret=1
    done
    return "$ret"
}

dotsync_setup() {
    for file in $syncd_files; do
        if ! diff -q >/dev/null "$target/$file" "$srcdir/$file"; then
            mkdir -p "$backupdir"
            cp -v "$targetdir/$file" "$backupdir/$file"
            cp -v "$srcdir/$file" "$targetdir/$file"
        fi
    done
}

dotsync_teardown() {
    return 0
}
