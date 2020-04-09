#!/bin/bash

# detect if this terminal support color
# (whitelisted, so non-color, unless we know we "want" color)
# FIXME this is not the correct way to look for color support; use the terminfo db
case "${TERM}" in
    xterm|xterm-color|*-256color) color_term=yes;;
esac


if [ "${color_term}" = yes ]; then
    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        if [ -r "${HOME}/.dircolors" ]; then
            eval "$(dircolors -b "${HOME}/.dircolors")"
        else
            eval "$(dircolors -b)"
        fi
        alias ls='ls --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    # colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# FIXME I have a much better interface to color in bin/colors.sh
# set shortcuts for color escapes
if [ "${color_term}" = yes ]; then
    col_CLR="\e[0m"

    col_NO="\e[39m"
    col_BLA="\e[30m"
    col_RED="\e[31m"
    col_GRE="\e[32m"
    col_YEL="\e[33m"
    col_BLU="\e[34m"
    col_MAG="\e[35m"
    col_CYA="\e[36m"
    col_LGRA="\e[37m"
    col_GRA="\e[90m"
    col_LRED="\e[91m"
    col_LGRE="\e[92m"
    col_LYEL="\e[93m"
    col_LBLU="\e[94m"
    col_LMAG="\e[95m"
    col_LCYA="\e[96m"
    col_WHI="\e[97m"

    bkg_NO="\e[49m"
    bkg_BLA="\e[40m"
    bkg_RED="\e[41m"
    bkg_GRE="\e[42m"
    bkg_YEL="\e[43m"
    bkg_BLU="\e[44m"
    bkg_MAG="\e[45m"
    bkg_CYA="\e[46m"
    bkg_LGRA="\e[47m"
    bkg_GRA="\e[100m"
    bkg_LRED="\e[101m"
    bkg_LGRE="\e[102m"
    bkg_LYEL="\e[103m"
    bkg_LBLU="\e[104m"
    bkg_LMAG="\e[105m"
    bkg_LCYA="\e[106m"
    bkg_WHI="\e[107m"

    sty_BOLD="\e[1m"
    sty_DIM="\e[2m"
    sty_ULINE="\e[4m"
    sty_BLINK="\e[5m"
    sty_INV="\e[7m"
    sty_HIDE="\e[8m"

    sty_NOBOLD="\e[21m"
    sty_NODIM="\e[22m"
    sty_NOULINE="\e[24m"
    sty_NOBLINK="\e[25m"
    sty_NOINV="\e[27m"
    sty_NOHIDE="\e[28m"
fi


unset color_term
