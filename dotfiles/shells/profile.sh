# FIXME I should probably set this umask, likely 027
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin directories
PATH="$PATH:$HOME/bin:$HOME/.local/bin"
# FIXME this looks like haskell dotfiles
PATH="$PATH:$HOME/.cabal/bin"


if [ -d "${HOME}/.profile.d" ]; then
    for profile in $(ls "${HOME}/.profile.d"); do
        case "${profile}" in
            *.sh)
                . "${HOME}/.profile.d/${profile}"
                ;;
            *) ;;
        esac
    done
fi
