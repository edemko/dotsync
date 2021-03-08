#!/bin/sh

srcdir="${dotdir}/src"
targetdir="${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml"
backupdir="${targetdir}.bak"
syncd_files='xfce4-keyboard-shortcuts.xml xfwm4.xml xsettings.xml'

dotsync_depsgood() {
    return 0
}

dotsync_newest() {
    for file in $syncd_files; do
        [ -L "$targetdir/$file" ] || return 1
    done
}

dotsync_setup() {
    for file in $syncd_files; do
        if [ ! -L "$target/$file" ]; then
            echo >&2 "$(withaf d0f '[NOTICE]') creating back-up of '$targetdir/$file' at '$backupdir/$file'"
            mkdir -p "$backupdir"
            mv "$targetdir/$file" "$backupdir/$file"
        fi
        ln -svf "$srcdir/$file" "$targetdir/$file"
    done
}

dotsync_teardown() {
    for file in $syncd_files; do
        [ -L "$targetdir/$file" ] && rm "$targetdir/$file"
        [ -e "$backupdir/$file" ] && mv "$backupdir/$file" "$targetdir/$file"
    done
    [ -d "$backupdir" ] && rm -r "$backupdir"
    return 0
}
