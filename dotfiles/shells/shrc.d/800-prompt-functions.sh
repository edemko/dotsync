__prompt_failcode() {
    (
        ec="${?}"
        if [[ ${ec} != 0 ]]; then
            echo "<${ec}>"
        fi
    )
}

__prompt_gitstatus() {
    local repodir branch st fetchhead
    if git rev-parse --git-dir >/dev/null 2>&1; then
        branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"

        fetchhead=$(git rev-parse --git-dir)/FETCH_HEAD
        # if 15 minutes ago is further ahead in time than the last time we fetched
        if [ ! -f "${fetchhead}" ] ||
           [ "$(date +'%s' -d'15 min ago')" -gt "$(stat -c'%Y' "${fetchhead}")" ]; then
            git remote update >/dev/null 2>/dev/null &
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
        if ( git show-branch "origin/${branch}" ${branch} 2>/dev/null | tail -n+4 | grep -q '^ [^ ]' ); then
            symbol+=↑
        fi

        st="$(git status --porcelain)"
        # untracked files reported as `!`
        if [ $(echo "${st}" | grep -c '^??') -ne 0 ]; then symbol+='!'; fi
        # unstaged files reported as `*`
        if [ -n "$(echo ${st} | grep -v '^??')" ]; then symbol+='*'; fi

        echo "(${symbol}${branch})"
    fi
}
