#!/bin/bash
set -e

cd "$(dirname "$0")"

cat /dev/fd/3 3<<'EOF' <(./latexianXCompose.hs <greek.txt) /dev/fd/4 4<<'EOF' >../XCompose.d/greek.xcompose
###            ###
# Greek Alphabet #
###            ###

### Long Names ###

EOF
### Shortcuts ###

<Multi_key> <f> <n>: "λ"

EOF