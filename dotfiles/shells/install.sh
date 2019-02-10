# entry points for shell configuration
profile="${HOME}/.profile"
profile_src="${1}/profile.sh"

bashrc="${HOME}/.bashrc"
bashrc_src="${1}/bashrc.bash"

# these are deleted to reduce complexity
bashlogin="${HOME}/.bash_login"
bashprofile="${HOME}/.bash_profile"

# directories for additional cofiguration to be plugged in
profiledir="${HOME}/.profile.d"
profiledir_src="${1}/profile.d"


dotsync_depsgood() { return 0 ; }

dotsync_newest() {
    diff -q "${profile}" "${profile_src}" || return 1
    [ -d "${profiledir}" ] || return 1

    [ -f "${bashprofile}" -o -L "${bashprofile}" ] && return 1
    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && return 1
    diff -q "${bashrc}" "${bashrc_src}" || return 1
}

dotsync_setup() {
    ln -srv "${profile_src}" "${profile}"
    mkdir -pv "${profiledir}"

    [ -f "${bashlogin}" -o -L "${bashlogin}" ] && rm -v "${bashlogin}"
    [ -f "${bashprofile}" -o -L "${bashprofile}" ] && rm -v "${bashprofile}"
    ln -srv "${bashrc_src}" "${bashrc}"
}

dotsync_teardown() {
    [ -L "${bashrc}" ] && rm -v "${bashrc}"
    [ -L "${profiledir}" ] && rm -r "${profiledir}"
    [ -L "${profile}" ] && rm -v "${profile}"
    return 0
}
