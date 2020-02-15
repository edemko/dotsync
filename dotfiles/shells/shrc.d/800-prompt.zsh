setopt promptsubst

# always clear any color
PS1="%{$(print -P "${col_CLR}")%}"

# what shell is being run?
PS1+="%{$(print -P ${col_GRA})%}"
PS1+="[zsh]"
PS1+="%{$(print -P ${col_CLR})%}"

# show last exit code if non-zero
PS1+="%{$(print -P ${col_RED})%}"
PS1+='$(__prompt_failcode)'
PS1+="%{$(print -P ${col_CLR})%}"

# FIXME this code is duplicated in the .bash version
# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="%{$(print -P ${sty_BOLD}${col_YEL})%}"
PS1+='${debian_chroot:+(${debian_chroot})}'
PS1+="%{$(print -P ${col_CLR})%}"

# FIXME this code is duplicated in the .bash version
# display current git branch
PS1+="%{$(print -P ${col_YEL})%}"
PS1+='$(__prompt_gitstatus)'
PS1+="%{$(print -P ${col_CLR})%}"

# user, host, and working directory
PS1+="%{$(print -P ${col_BLU})%}"
PS1+="%n@%M:"
PS1+="%{$(print -P ${col_LBLU})%}"
PS1+="%(3~|.../|)%3~"
PS1+="%{$(print -P ${col_CLR})%}"

# dollar or hash for prompt
PS1+="%{$(print -P ${col_GRE})%}"
PS1+="%(!.#.$)"
PS1+="%{$(print -P ${col_CLR})%}"

# lebensraum
PS1+=" "


# ZLE_RPROMPT_INDENT=0 # This seems to break counting
# RPS1='%(?.<%?>.<%F{red}%B%?%b>%f)'


# parser state, then caret
PS2="%_>"
