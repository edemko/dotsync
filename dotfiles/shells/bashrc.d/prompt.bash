# always clear any color
PS1="\[${col_CLR}\]"
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
# number of background jobs
PS1+="\[${col_GRA}\][j:\j]\[${col_CLR}\]"
# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="\[${sty_BOLD}${col_YEL}\]"'${debian_chroot:+($debian_chroot)}'"\[${col_CLR}\]"
# display current git branch
if which git; then
    __prompt_gitbranch() {
        git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
    PS1+="\[${col_YEL}\]\$(__prompt_gitbranch)\[${col_CLR}\]"
fi
# user, host, and working directory
PS1+="\[${col_BLU}\]\u@\h:\[${col_LBLU}\]\w\[${col_CLR}\]"
# dollar or hash for prompt
PS1+="\[${sty_BOLD}${sty_DIM}${col_WHI}\]\$\[${col_CLR}\] "

# always clear any color
PS2="\[${col_CLR}\]"
# a simple caret is enough
PS2+="\[${sty_BOLD}${sty_DIM}${col_WHI}\]>\[${col_CLR}\] "
