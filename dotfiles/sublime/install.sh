packagesdir="${HOME}/.config/sublime-text-3/Packages/User"
packagesdir_src="${1}/Packages/User"
#------
preferences="${packagesdir}/Preferences.sublime-settings"
keymap="${packagesdir}/Default (Linux).sublime-keymap"
mousemap="${packagesdir}/Default.sublime-mousemap"
packageControl="${packagesdir}/Package Control.sublime-settings"
surround="${packagesdir}/surround.sublime-settings"
#------
keymap_src="${packagesdir_src}/Default (Linux).sublime-keymap"
mousemap_src="${packagesdir_src}/Default.sublime-mousemap"
preferences_src="${packagesdir_src}/Preferences.sublime-settings"
packageControl_src="${packagesdir_src}/Package Control.sublime-settings"
surround_src="${packagesdir_src}/surround.sublime-settings"
#------
bashlang="${packagesdir}/Bash.sublime-settings"
bashlang_src="${packagesdir_src}/Bash.sublime-settings"
markdownlang="${packagesdir}/Markdown.sublime-settings"
markdownlang_src="${packagesdir_src}/Markdown.sublime-settings"
textlang="${packagesdir}/Plain text.sublime-settings"
textlang_src="${packagesdir_src}/Plain text.sublime-settings"
#------

dotsync_depsgood() {
    if ! (dpkg -l sublime-text | grep -q ^ii); then
        echo >&2 "$(withaf f00 '[ERROR]') Sublime Text not installed. See https://www.sublimetext.com/docs/3/linux_repositories.html#apt"
        return 1
    fi
    if ! (fc-list | grep -q 'Source Code Pro'); then
        echo >&2 "$(withaf f80 '[WARNING]') Source Code Pro not installed."
    fi
    return 0
}

dotsync_newest() {
    diff -q 2>/dev/null "${vimrc}" "${vimrc_src}" || return 1

    [ -d "${packagesdir}" ] || return 1
    diff -q "${preferences}" "${preferences_src}" || return 1
    diff -q "${keymap}" "${keymap_src}" || return 1
    diff -q "${mousemap}" "${mousemap_src}" || return 1
    diff -q "${packageControl}" "${packageControl_src}" || return 1
    diff -q "${surround}" "${surround_src}" || return 1

    diff -q "${bashlang}" "${bashlang_src}" || return 1
    diff -q "${markdownlang}" "${markdownlang_src}" || return 1
    diff -q "${textlang}" "${textlang_src}" || return 1

    return 0
}

dotsync_setup() {
    mkdir -pv "${packagesdir}"

    diff -q >/dev/null "${preferences_src}" "${preferences}" || \
        cp -v "${preferences_src}" "${preferences}"
    diff -q >/dev/null "${keymap_src}" "${keymap}" || \
        cp -v "${keymap_src}" "${keymap}"
    diff -q >/dev/null "${mousemap_src}" "${mousemap}" || \
        cp -v "${mousemap_src}" "${mousemap}"
    if ! ( diff -q >/dev/null "${packageControl}" "${packageControl_src}" ); then
        echo >&2 "$(withaf d0f '[NOTICE]') Package Control package list updated."
        echo >&2 "$(withaf d0f '[NOTICE]') Packages will be synced on next sublime text restart."
        echo >&2 "$(withaf d0f '[NOTICE]') See https://packagecontrol.io/docs/syncing"
        cp -v "${packageControl_src}" "${packageControl}"
    fi
    diff -q >/dev/null "${surround_src}" "${surround}" || \
        cp -v "${surround_src}" "${surround}"

    diff -q >/dev/null "${bashlang_src}" "${bashlang}" || \
        cp -v "${bashlang_src}" "${bashlang}"
    diff -q >/dev/null "${markdownlang_src}" "${markdownlang}" || \
        cp -v "${markdownlang_src}" "${markdownlang}"
    diff -q >/dev/null "${textlang_src}" "${textlang}" || \
        cp -v "${textlang_src}" "${textlang}"
}

dotsync_teardown() {
    return 0
}
