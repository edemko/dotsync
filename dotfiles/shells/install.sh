# entry points for shell configuration
profile="${HOME}/.profile"
profile_src="${1}/profile.sh"

bashrc="${HOME}/.bashrc"
bashrc_src="${1}/bashrc.bash"
bashlogout="${HOME}/.bash_logout"
bashlogout_src="${1}/bash_logout.bash"

zprofile="${HOME}/.zprofile"
zprofile_src="${1}/profile.zsh"
zshrc="${HOME}/.zshrc"
zshrc_src="${1}/zshrc.zsh"
zlogout="${HOME}/.zlogout"
zlogout_src="${1}/logout.zsh"
# TODO zlogout

# these are deleted to reduce complexity
bashprofile="${HOME}/.bash_profile"
bashlogin="${HOME}/.bash_login"
zshenv="${HOME}/.zshenv"
zlogin="${HOME}/.zlogin"

# directories for additional cofiguration to be plugged in
profiledir="${HOME}/.profile.d"
# profiledir_src="${1}/profile.d"

shrcdir="${HOME}/.shrc.d"
shrcdir_src="${1}/shrc.d"


dotsync_depsgood() { return 0 ; }

dotsync_newest() {
    diff -q "${profile}" "${profile_src}" || return 1
    [ -d "${profiledir}" ] || return 1

    [ -f "${bashprofile}" -o -L "${bashprofile}" ] && return 1
    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && return 1
    diff -q "${bashrc}" "${bashrc_src}" || return 1
    diff -q "${bashlogout}" "${bashlogout_src}" || return 1

    [ -f "${zshenv}" -o -L "${zshenv}" ] && return 1
    [ -f "${zlogin}" -o -L "${zlogin}" ] && return 1
    diff -q "${zprofile}" "${zprofile_src}" || return 1
    diff -q "${zshrc}" "${zshrc_src}" || return 1
    diff -q "${zshlogout}" "${zshlogout_src}" || return 1

    [ -d "${shrcdir}" ] || return 1
    for rc in $(ls "${shrcdir_src}"); do
        case "$rc" in
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
    ln -srvf "${profile_src}" "${profile}"
    mkdir -pv "${profiledir}"

    [ -e "${bashprofile}" ] && rm -v "${bashprofile}"
    [ -e "${bashlogin}" ] && rm -v "${bashlogin}"
    ln -srvf "${bashrc_src}" "${bashrc}"
    ln -srvf "${bashlogout_src}" "${bashlogout}"

    [ -e "${zshenv}" ] && rm -v "${zshenv}"
    [ -e "${zlogin}" ] && rm -v "${zlogin}"
    ln -srvf "${zprofile_src}" "${zprofile}"
    ln -srvf "${zshrc_src}" "${zshrc}"
    ln -srvf "${zlogout_src}" "${zlogout}"

    mkdir -pv "${shrcdir}"
    for rc in $(ls "${shrcdir_src}"); do
        case "$rc" in
            *.d|*.sh|*.bash|*.zsh)
                ln -srvf "${shrcdir_src}/${rc}" "${shrcdir}/${rc}"
                ;;
        esac
    done
}

dotsync_teardown() {
    [ -L "${profile}" ] && rm -v "${profile}"
    [ -d "${profiledir}" ] && rm -r "${profiledir}"
    [ -L "${bashrc}" ] && rm -v "${bashrc}"
    [ -L "${bashlogout}" ] && rm -v "${bashlogout}"
    [ -L "${zshrc}" ] && rm -v "${zshrc}"
    [ -d "${shrcdir}" ] && rm -r "${shrcdir}"
    # TODO
    # [ -d "${zshrcdir}" ] && rm -r "${zshrcdir}"
    return 0
}
