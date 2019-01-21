#!/bin/bash
set -e

cd "$(dirname "$0")"

cat /dev/fd/3 3<<'EOF' <(./latexianXCompose.hs <greek.txt) >../XCompose.d/greek.xcompose
###            ###
# Greek Alphabet #
###            ###

### Long Names ###

EOF

