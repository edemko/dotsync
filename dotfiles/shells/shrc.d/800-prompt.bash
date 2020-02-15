# always clear any color
PS1="\[${col_CLR}\]"
# what shell is being run?
PS1+="\[${col_GRA}\][bash]\[${col_CLR}\]"
# show last exit code if non-zero
PS1+="\[${col_RED}\]\$(__prompt_failcode)\[${col_CLR}\]"
# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="\[${sty_BOLD}${col_YEL}\]"'${debian_chroot:+(${debian_chroot})}'"\[${col_CLR}\]"
# display current git branch
PS1+="\[${col_YEL}\]\$(__prompt_gitstatus)\[${col_CLR}\]"
# user, host, and working directory
PROMPT_DIRTRIM=3
PS1+="\[${col_BLU}\]\u@\H:\[${col_LBLU}\]\w\[${col_CLR}\]"
# dollar or hash for prompt
PS1+="\[${col_GRE}\]\$\[${col_CLR}\]"
# lebensraum
PS1+=" "


# always clear any color
PS2="\[${col_CLR}\]"
# a simple caret is enough
PS2+="\[${sty_BOLD}${sty_DIM}${col_WHI}\]>\[${col_CLR}\] "
