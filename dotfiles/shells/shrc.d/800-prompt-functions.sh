__prompt_failcode() {
    (
        ec="$?"
        if [[ $ec != 0 ]]; then
            echo "<${ec}>"
        fi
    )
}

__prompt_gitstatus() {
    (
        if git rev-parse --git-dir >/dev/null 2>&1; then
            st="$(git status --porcelain)"
            if [ $(echo "$st" | grep -c '^??') -ne 0 ]; then symbol+='!'; fi
            if [ -n "$(echo $st | grep -v '^??')" ]; then symbol+='*'; fi
            branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
            echo "(${symbol}${branch})"
        fi
    )
}
