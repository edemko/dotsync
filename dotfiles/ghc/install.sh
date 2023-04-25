#!/bin/sh

ghcupSrc="${dotdir}/ghcup"
ghcupTarget="${HOME}/.ghcup"

ghciSrc="${dotdir}/ghci"
ghciTarget="${HOME}/.ghci"

dotsync_depsgood() {
  if ! which ghcup; then
    echo >&2 "$(withaf f80 '[WARNING]') GHCup not installed."
  fi
  return 0;
}

dotsync_newest() {
  diff -q 2>/dev/null "${ghcupSrc}/config.yaml" "${ghcupTarget}/config.yaml" || return 1
  # TODO check that ghcup is latest
  diff -q 2>/dev/null "${ghciTarget}" "${ghciSrc}" || return 1
}

dotsync_setup() {
  ln -svf "${ghcupSrc}/config.yaml" "${ghcupTarget}/config.yaml"
  # TODO ghcup upgrade
  ln -svf "${ghciSrc}" "${ghciTarget}"
  chmod go-w "${ghciTarget}"
}

dotsync_teardown() {
  [ -L "${ghciTarget}" ] && rm -v "${ghciTarget}"
  return 0
}
