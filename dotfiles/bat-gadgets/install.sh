#!/bin/sh

bindir="${HOME}/bin"
bindir_src="${dotdir}/bin"

dotsync_depsgood() {
    case ":${PATH}:" in
        *:${bindir}:*) ;;
        *) echo >&2 "$(withaf f80 '[WARNING]') '${bindir}' is not on the PATH" ;;
    esac
    return 0
}

dotsync_newest() {
    local apps
    apps="gitstat lolcat technicolor tree pv"
    for app in ${apps}; do
        which "${app}" || return 1
    done
    return 0
}

dotsync_setup() {
    mkdir -pv "${bindir}"

    which >/dev/null gitstat || ln -svf "${bindir_src}/gitstat.sh" "${bindir}/gitstat"

    [ -d "${bindir}/technicolor.d" ] || git clone 'https://github.com/Zankoku-Okuno/technicolor' "${bindir}/technicolor.d"
    [ -L "${bindir}/technicolor" ] || ln -svf "${bindir}/technicolor.d/technicolor" "${bindir}/technicolor"

    which >/dev/null tree || echo >&2 "$(withaf f80 '[WARNING]') 'tree' not installed. Try 'sudo apt install tree'."

    which >/dev/null lolcat || echo >&2 "$(withaf f80 '[WARNING]') 'lolcat' not installed. Try 'sudo apt install lolcat'."
}

dotsync_teardown() {
    which >/dev/null tree || echo >&2 "$(withaf f80 '[WARNING]') 'tree' still installed. Try 'sudo apt remove tree'."

    which >/dev/null lolcat || echo >&2 "$(withaf f80 '[WARNING]') 'lolcat' still installed. Try 'sudo apt remove lolcat'."

    [ -L "${bindir}/technicolor" ] && rm "${bindir}/technicolor"
    [ -d "${bindir}/technicolor.d" ] && rm -rf "${bindir}/technicolor.d"

    [ -L "${bindir}/gitstat" ] && rm "${bindir}/gitstat"
}
