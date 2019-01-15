#!/bin/sh

basedir="$(dirname "${0}")"
dotdir="${basedir}/dotfiles"


grep -r 'echo [^>][^&][^2][^ ]' "${dotdir}"
grep -r '\$[^({]' "${dotdir}"
