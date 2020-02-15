#!/bin/sh

_gitstat_fetch() {
    local timespec repodir fetchhead
    timespec="$1"
    repodir="$2"
    fetchhead="$(cd "${repodir}"; git rev-parse --git-dir)/FETCH_HEAD"
    [ -z "${fetchhead}" ] && exit 127
    if [ ! -f "${fetchhead}" ] ||
       [ "$(stat -c'%Y' "${fetchhead}")" -lt "$(date +'%s' -d "${timespec}")" ]; then
        exit 1
    else
        exit 0
    fi
}

_die_usage() {
    echo >&2 "Usage: ${0} [-d <time spec>] <git repo>"
    exit 127
}

while getopts "d:" arg; do
    timespec='00:00 today'
    case "$arg" in
        d) timespec="${OPTARG}" ;;
        *) _die_usage ;;
    esac
done
shift $(expr $OPTIND - 1)
case "$#" in
    0) _gitstat_fetch "${timespec}" "${PWD}" ;;
    1) _gitstat_fetch "${timespec}" "${1}" ;;
    *) _die_usage;;
esac
