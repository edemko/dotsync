#!/bin/bash
shopt -s globstar

basedir="$(dirname "${0}")"
dotdir="${basedir}/dotfiles"


grep -P --color 'echo(?![^|]+>&2\b|.* \| )' "${dotdir}/"**/*.{,ba,z}sh
grep --color '\$[^(){}/\\]' "${dotdir}/"**/*.{,ba,z}sh
