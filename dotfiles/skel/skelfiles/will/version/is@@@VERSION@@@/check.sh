#!/bin/sh
set -e

exec >/dev/null 2>/dev/null

test -x "$(command -v @@@PROGRAM=$(basename "$PWD")@@@ 2>/dev/null)"
@@@PROGRAM=$(basename "$PWD")@@@ --version | grep -q '^@@@MATCH_STRING@@@'

