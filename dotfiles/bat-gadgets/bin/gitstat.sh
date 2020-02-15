#!/bin/sh

_gitstat_fetch() {
    local timespec repodir fetchhead
    timespec="$1"
    repodir="$2"

    [ -d "${repodir}" ] || exit 1
    fetchhead="$(cd "${repodir}"; git rev-parse --git-dir)/FETCH_HEAD"
    [ -f "${fetchhead}" ] || exit 1
    [ "$(date +'%s' -d "${timespec}")" -lt "$(stat -c'%Y' "${fetchhead}")" ] || exit 1

    exit 0
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
