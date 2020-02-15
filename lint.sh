#!/bin/bash
shopt -s globstar

basedir="$(dirname "${0}")"
dotdir="${basedir}/dotfiles"
bindir="${basedir}/bin"




echo '############ List of Used Colors ############'
grep -Poh --color=never '(?<=withaf )([0-9a-fA-F]{3}){1,2} (['\'\"']\[[A-Z]+\]'\''|[^)]+)' \
    "${dotdir}/"*/install.sh "${bindir}/"* |
    sort -u || echo none

echo '############ uncolorized notifications ############'
grep -P --color=always '\[[A-Z]+\]' "${dotdir}/"*/install.sh "${bindir}/"* |
    grep -viP --color=always 'withaf ([0-9a-f]{3}){1,2} '\''\e' |
    grep -viP --color=always '\$\(tput setaf \d{1,3}\)\e' || echo ok

echo '############ Echo to Elsewhere than Stderr ############'
grep -P --color=always 'echo(?![^|]+>&2\b|.* \| )' "${dotdir}/"**/*.{,ba,z}sh || echo ok

echo '############ Missing Expansion Brackets ############'
grep --color=always '\$[^(){}/\\]' "${dotdir}/"*/install.sh "${bindir}/"* || echo ok


