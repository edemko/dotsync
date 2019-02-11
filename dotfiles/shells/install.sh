# entry points for shell configuration
profile="${HOME}/.profile"
profile_src="${1}/profile.sh"

bashrc="${HOME}/.bashrc"
bashrc_src="${1}/bashrc.bash"
bashlogout="${HOME}/.bash_logout"
bashlogout_src="${1}/bash_logout.bash"

zshrc="${HOME}/.zshrc"
zshrc_src="${1}/zshrc.zsh"

# these are deleted to reduce complexity
bashlogin="${HOME}/.bash_login"
bashprofile="${HOME}/.bash_profile"

# directories for additional cofiguration to be plugged in
profiledir="${HOME}/.profile.d"
# profiledir_src="${1}/profile.d"

bashrcdir="${HOME}/.bashrc.d"
bashrcdir_src="${1}/bashrc.d"

zshrcdir="${HOME}/.zshrc.d"
zshrcdir_src="${1}/zshrc.d"


dotsync_depsgood() { return 0 ; }

dotsync_newest() {
    diff -q "${profile}" "${profile_src}" || return 1
    [ -d "${profiledir}" ] || return 1

    [ -f "${bashprofile}" -o -L "${bashprofile}" ] && return 1
    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && return 1
    diff -q "${bashrc}" "${bashrc_src}" || return 1
    diff -q "${bashlogout}" "${bashlogout_src}" || return 1
    [ -d "${bashrcdir}" ] || return 1
    for rc in $(ls "${bashrcdir_src}"); do
        diff -q "${bashrcdir}/${rc}" "${bashrcdir_src}/${rc}" || return 1
    done

    diff -q "${zshrc}" "${zshrc_src}" || return 1
    # TODO
    # [ -d "${zshrcdir}" ] || return 1
    # for rc in $(ls "${zshrcdir_src}"); do
    #     diff -q "${zshrcdir}/${rc}" "${zshrcdir_src}/${rc}" || return 1
    # done
    return 0
}

dotsync_setup() {
    ln -srvf "${profile_src}" "${profile}"
    mkdir -pv "${profiledir}"

    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && rm -v "${bashlogin}"
    [ -f "${bashprofile}" -o -L "${bashprofile}" ] && rm -v "${bashprofile}"
    ln -srvf "${bashrc_src}" "${bashrc}"
    ln -srvf "${bashlogout_src}" "${bashlogout}"
    mkdir -pv "${bashrcdir}"
    for rc in $(ls "${bashrcdir_src}"); do
        ln -srvf "${bashrcdir_src}/${rc}" "${bashrcdir}/${rc}"
    done

    ln -srvf "${zshrc_src}" "${zshrc}"
    # TODO
    # mkdir -pv "${zshrcdir}"
    # for rc in $(ls "${zshrcdir_src}"); do
    #     ln -srvf "${zshrcdir_src}/${rc}" "${zshrcdir}/${rc}"
    # done
}

dotsync_teardown() {
    [ -L "${profile}" ] && rm -v "${profile}"
    [ -d "${profiledir}" ] && rm -r "${profiledir}"
    [ -L "${bashrc}" ] && rm -v "${bashrc}"
    [ -L "${bashlogout}" ] && rm -v "${bashlogout}"
    [ -d "${bashrcdir}" ] && rm -r "${bashrcdir}"
    [ -L "${zshrc}" ] && rm -v "${zshrc}"
    # TODO
    # [ -d "${zshrcdir}" ] && rm -r "${zshrcdir}"
    return 0
}
