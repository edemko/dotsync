#!/bin/sh

sublimedir="${HOME}/.config/sublime-text-3"
#------
packagesdir="${sublimedir}/Packages/User"
packagesdir_src="${dotdir}/Packages/User"
#------
preferences="${packagesdir}/Preferences.sublime-settings"
keymap="${packagesdir}/Default (Linux).sublime-keymap"
mousemap="${packagesdir}/Default.sublime-mousemap"
packageControl="${packagesdir}/Package Control.sublime-settings"
#------
keymap_src="${packagesdir_src}/Default (Linux).sublime-keymap"
mousemap_src="${packagesdir_src}/Default.sublime-mousemap"
preferences_src="${packagesdir_src}/Preferences.sublime-settings"
packageControl_src="${packagesdir_src}/Package Control.sublime-settings"
#------
nice_package_names='Markdown surround'
# annoying package names
textlang="${packagesdir}/Plain text.sublime-settings"
textlang_src="${packagesdir_src}/Plain text.sublime-settings"
#------
manualdir="${sublimedir}/Packages"
manual_packages="Haskell Lunarized"
#------

dotsync_depsgood() {
    if ! (dpkg -l sublime-text | grep -q ^ii); then
        echo >&2 "$(withaf f00 '[ERROR]') Sublime Text not installed. See https://www.sublimetext.com/docs/3/linux_repositories.html#apt"
        return 1
    fi
    if ! (fc-list | grep -q 'Source Code Pro'); then
        echo >&2 "$(withaf f80 '[WARNING]') Source Code Pro not installed."
    fi
    if ! (fc-list | grep -q 'Eexpr Reference Mono'); then
        echo >&2 "$(withaf f80 '[WARNING]') Eexpr Reference Mono not installed."
    fi
    if ! (which shellcheck >/dev/null); then
        echo >&2 "$(withaf f80 '[WARNING]') shellcheck not installed."
    fi
    return 0
}

dotsync_newest() {
    local ret
    ret=0
    [ -d "${packagesdir}" ] || ret=1
    diff -q "${preferences}" "${preferences_src}" || ret=1
    # echo >&2 hi
    diff -q "${keymap}" "${keymap_src}" || ret=1
    diff -q "${mousemap}" "${mousemap_src}" || ret=1

    diff -q "${packageControl}" "${packageControl_src}" || ret=1

    for pkg in $nice_package_names; do
        diff -q "${packagesdir}/${pkg}.sublime-settings" "${packagesdir_src}/${pkg}.sublime-settings" || ret=1
    done
    diff -q "${textlang}" "${textlang_src}" || ret=1

    for pkg in $manual_packages; do
        gitstat "${manualdir}/${pkg}" || return 1
    done

    return ${ret}
}

dotsync_setup() {
    mkdir -pv "${packagesdir}"

    diff -q >/dev/null "${preferences_src}" "${preferences}" || \
        cp -v "${preferences_src}" "${preferences}"
    diff -q >/dev/null "${keymap_src}" "${keymap}" || \
        cp -v "${keymap_src}" "${keymap}"
    diff -q >/dev/null "${mousemap_src}" "${mousemap}" || \
        cp -v "${mousemap_src}" "${mousemap}"

    if ! diff -q >/dev/null "${packageControl}" "${packageControl_src}"; then
        echo >&2 "$(withaf d0f '[NOTICE]') Package Control package list updated."
        echo >&2 "$(withaf d0f '[NOTICE]') Packages will be synced on next sublime text restart."
        echo >&2 "$(withaf d0f '[NOTICE]') See https://packagecontrol.io/docs/syncing"
        cp -v "${packageControl_src}" "${packageControl}"
    fi

    for pkg in $nice_package_names; do
        if ! diff -q >/dev/null "${packagesdir_src}/${pkg}.sublime-settings" "${packagesdir}/${pkg}.sublime-settings"; then
            cp -v "${packagesdir_src}/${pkg}.sublime-settings" "${packagesdir}/${pkg}.sublime-settings"
        fi
    done
    if ! diff -q >/dev/null "${textlang_src}" "${textlang}"; then
        cp -v "${textlang_src}" "${textlang}"
    fi

    for pkg in $manual_packages; do
        if ! [ -d "$manualdir/$pkg" ]; then
            git clone "ssh://git@github.com/Zankoku-Okuno/sublime-${pkg}" "$manualdir/$pkg"
        fi
        if ! gitstat "$manualdir/$pkg"; then
            (cd "$manualdir/$pkg" && git pull)
        fi
    done
}

dotsync_teardown() {
    return 0
}
