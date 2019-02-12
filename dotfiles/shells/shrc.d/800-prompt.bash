# always clear any color
PS1="\[${col_CLR}\]"
# what shell is being run?
PS1+="\[${col_GRA}\][$(basename "${SHELL}")]\[${col_CLR}\]"
# show last exit code if non-zero
__prompt_failcode() {
    (
        ec="$?"
        if [[ $ec != 0 ]]; then
            echo "<${ec}> "
        fi
    )
}
PS1+="\[${col_RED}\]\$(__prompt_failcode)\[${col_CLR}\]"
# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="\[${sty_BOLD}${col_YEL}\]"'${debian_chroot:+($debian_chroot)}'"\[${col_CLR}\]"
# display current git branch
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
PS1+="\[${col_YEL}\]\$(__prompt_gitstatus)\[${col_CLR}\]"
# user, host, and working directory
PS1+="\[${col_BLU}\]\u@\h:\[${col_LBLU}\]\w\[${col_CLR}\]"
# dollar or hash for prompt
PS1+="\[${sty_BOLD}${sty_DIM}${col_WHI}\]\$\[${col_CLR}\] "

# always clear any color
PS2="\[${col_CLR}\]"
# a simple caret is enough
PS2+="\[${sty_BOLD}${sty_DIM}${col_WHI}\]>\[${col_CLR}\] "
