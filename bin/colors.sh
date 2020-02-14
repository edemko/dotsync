#!/bin/sh


hexToColor() {
    local hex r g b
    hex="${1}"
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 + 
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}

withfg() {
    local hex text
    hex="${1}"
    text="${2}"
    echo "$(tput setaf "$(hexToColor "${hex}")")${text}$(tput sgr0)"
}

case "${1}" in
    "test")
        echo "Colors: $(tput colors)" >&2
        for i in $(seq 0 `expr $(tput colors) - 1`); do
            echo -n "$(tput setaf $i)${i}$(tput sgr0)\t"
        done
        echo "" >&2
        ;;
    "code")
        echo "$(withfg "${2}" "$(hexToColor ${2})")  $(tput setab "$(hexToColor ${2})")   $(tput sgr0)"
        ;;
    "") # do nothing
        ;;
    *) withfg ${1} ${2}
        ;;
esac

