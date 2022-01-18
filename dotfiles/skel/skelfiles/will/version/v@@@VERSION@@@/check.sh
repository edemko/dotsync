#!/bin/sh
set -e

test -x "$(command -v @@@PROGRAM=$(basename "$PWD")@@@-v@@@VERSION@@@ 2>/dev/null)" >/dev/null 2>&1

