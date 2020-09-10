#!/bin/sh

# entry points for shell configuration
profile="${HOME}/.profile"
profile_src="${dotdir}/profile.sh"

bashprofile="${HOME}/.bash_profile"
bashprofile_src="${dotdir}/bash_profile.bash"
bashrc="${HOME}/.bashrc"
bashrc_src="${dotdir}/bashrc.bash"
bashlogout="${HOME}/.bash_logout"
bashlogout_src="${dotdir}/bash_logout.bash"

zprofile="${HOME}/.zprofile"
zprofile_src="${dotdir}/profile.zsh"
zshrc="${HOME}/.zshrc"
zshrc_src="${dotdir}/zshrc.zsh"
zlogout="${HOME}/.zlogout"
zlogout_src="${dotdir}/logout.zsh"
# TODO zlogout

# these are deleted to reduce complexity
bashlogin="${HOME}/.bash_login"
zshenv="${HOME}/.zshenv"
zlogin="${HOME}/.zlogin"

# directories for additional cofiguration to be plugged in
profiledir="${HOME}/.profile.d"
# profiledir_src="${dotdir}/profile.d"

shrcdir="${HOME}/.shrc.d"
shrcdir_src="${dotdir}/shrc.d"


dotsync_depsgood() { return 0 ; }

dotsync_newest() {
    diff -q "${profile}" "${profile_src}" || return 1
    [ -d "${profiledir}" ] || return 1

    diff -q "${bashprofile}" "${bashprofile_src}" || return 1
    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && return 1
    diff -q "${bashrc}" "${bashrc_src}" || return 1
    diff -q "${bashlogout}" "${bashlogout_src}" || return 1

    [ -f "${zshenv}" -o -L "${zshenv}" ] && return 1
    [ -f "${zlogin}" -o -L "${zlogin}" ] && return 1
    diff -q "${zprofile}" "${zprofile_src}" || return 1
    diff -q "${zshrc}" "${zshrc_src}" || return 1
    diff -q "${zlogout}" "${zlogout_src}" || return 1

    [ -d "${shrcdir}" ] || return 1
    for rc in "${shrcdir_src}"/*; do
        rc="$(basename "$rc")"
        case "${rc}" in
            *.d)
                [ -d "${shrcdir}/${rc}" ] || return 1
                ;;
            *.sh|*.bash|*.zsh)
                diff -q "${shrcdir}/${rc}" "${shrcdir_src}/${rc}" || return 1
                ;;
        esac
    done
    return 0
}

dotsync_setup() {
    ln -svf "${profile_src}" "${profile}"
    mkdir -pv "${profiledir}"

    ln -svf "${bashprofile_src}" "${bashprofile}"
    [ -e "${bashlogin}" ] && rm -v "${bashlogin}"
    ln -svf "${bashrc_src}" "${bashrc}"
    ln -svf "${bashlogout_src}" "${bashlogout}"

    [ -e "${zshenv}" ] && rm -v "${zshenv}"
    [ -e "${zlogin}" ] && rm -v "${zlogin}"
    ln -svf "${zprofile_src}" "${zprofile}"
    ln -svf "${zshrc_src}" "${zshrc}"
    ln -svf "${zlogout_src}" "${zlogout}"

    mkdir -pv "${shrcdir}"
    for rc in "${shrcdir_src}"/*; do
        rc="$(basename "$rc")"
        case "${rc}" in
            *.d|*.sh|*.bash|*.zsh)
                ln -sTvf "${shrcdir_src}/${rc}" "${shrcdir}/${rc}"
                ;;
        esac
    done
}

dotsync_teardown() {
    [ -L "${profile}" ] && rm -v "${profile}"
    [ -d "${profiledir}" ] && rm -r "${profiledir}"
    [ -L "${bashprofile}" ] && rm -v "${bashprofile}"
    [ -L "${bashrc}" ] && rm -v "${bashrc}"
    [ -L "${bashlogout}" ] && rm -v "${bashlogout}"
    [ -L "${zshrc}" ] && rm -v "${zshrc}"
    [ -d "${shrcdir}" ] && rm -r "${shrcdir}"
    # TODO
    # [ -d "${zshrcdir}" ] && rm -r "${zshrcdir}"
    return 0
}
