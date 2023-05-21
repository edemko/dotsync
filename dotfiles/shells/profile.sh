#!/bin/sh

# FIXME I should probably set this umask, likely 027
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin directories
if ! echo ":${PATH}:" | grep -q ":${HOME}/bin:"; then
    export PATH="${PATH}:${HOME}/bin"
fi
if ! echo ":${PATH}:" | grep -q ":${HOME}/.local/bin:"; then
    export PATH="${PATH}:${HOME}/.local/bin"
fi
# FIXME this looks like haskell dotfiles
if ! echo ":${PATH}:" | grep -q ":${HOME}/.ghcup/bin:"; then
    export PATH="${PATH}:${HOME}/.ghcup/bin"
fi
if ! echo ":${PATH}:" | grep -q ":/opt/ghc/bin:"; then
    export PATH="${PATH}:/opt/ghc/bin"
fi
if ! echo ":${PATH}:" | grep -q ":/opt/cabal/bin:"; then
    export PATH="${PATH}:/opt/cabal/bin"
fi
if ! echo ":${PATH}:" | grep -q ":${HOME}/.cabal/bin:"; then
    export PATH="${PATH}:${HOME}/.cabal/bin"
fi
if ! echo "${PATH}" | grep -q "${HOME}/.cargo/bin"; then
    export PATH="${PATH}:${HOME}/.cargo/bin"
fi

# Look in my usual NodeJS install folder.
# I have to manually put a file there called `.installed` which holds the name of the subdirectory for the node version I want installed.
if [ -f "${HOME}/Programs/nodejs/.installed" ]; then
    if ! echo "${PATH}" | grep -q "$(cat "${HOME}/Programs/nodejs/.installed")/bin"; then
        export PATH="${PATH}:$(cat "${HOME}/Programs/nodejs/.installed")/bin"
    fi
fi


if [ -d "${HOME}/.profile.d" ]; then
    for profile in "${HOME}"/.profile.d/*; do
        case "${profile}" in
            *.sh)
                . "${profile}"
                ;;
            *) ;;
        esac
    done
fi
