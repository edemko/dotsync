#!/bin/sh

__prompt_failcode() {
    (
        ec="${?}"
        if [ ${ec} != 0 ]; then
            echo "<${ec}>"
        fi
    )
}

__prompt_gitstatus() {
    # preserve last exitcode by running in a subshell
    # `return` isn't good enough, so I have to use `exit`
    # TODO could probably put more effort in to both do the thing and exit with the right code
    (
        local ec=$?
        if [ -z $ec ]; then exit $ec; fi

        local branch st
        if git rev-parse --git-dir >/dev/null 2>&1; then
            branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"

            # if last fetch was over  an hour ago, update remotes
            if which gitstat >/dev/null 2>&1; then
                gitstat -d'1 hour ago' || git remote update >/dev/null 2>/dev/null &
            fi
            # if remote master has commits that local branch is missing, be sure to rebase
            if [ "${branch}" != "master" ]; then
                if ( git show-branch "origin/master" "${branch}" 2>/dev/null | tail -n+4 | grep -q '^[^ ] ' ); then
                    symbol+=⇓
                fi
            fi
            # if remote branch has commits that local branch is missing, be sure to pull
            if ( git show-branch "origin/${branch}" "${branch}" 2>/dev/null | tail -n+4 | grep -q '^[^ ] ' ); then
                symbol+=↓
            fi
            # if the origin branch is missing commits that local branch has, be sure to push
            if ( git show-branch "origin/${branch}" "${branch}" 2>/dev/null | tail -n+4 | grep -q '^ [^ ]' ); then
                symbol+=↑
            fi

            st="$(git status --porcelain)"
            # untracked files reported as `!`
            if echo "${st}" | grep -q '^??'; then symbol+='!'; fi
            # unstaged files reported as `*`
            if echo "${st}" | grep -q '^ M'; then symbol+='*'; fi

            echo "(${symbol}${branch})"
        fi
    )
}

__prompt_ddate() {
    # preserve last exitcode by running in a subshell
    # `return` isn't good enough, so I have to use `exit`
    # TODO could probably put more effort in to both do the thing and exit with the right code
    (
        local ec=$?
        if [ -z $ec ]; then exit $ec; fi

        local touch_file
        touch_file="${HOME}/.shrc.d/.last-ddate"
        [ -f "${touch_file}" ] \
            && [ "$(date +'%s' -d "2 hours ago")" -lt "$(stat -c'%Y' "${touch_file}")" ] \
            && return 0
        which ddate >/dev/null || return 0

        touch "${touch_file}"
        if which lolcat >/dev/null; then
            ddate | lolcat -f
        elif which technicolor >/dev/null; then
            technicolor d0f "$(ddate)"
        else
            ddate
        fi
        # this `tput sgr0` also ensures the trailing newline from ddate doesn't get stripped by command substitution
        tput sgr0
    )
}
