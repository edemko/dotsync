#!/bin/zsh

for rc in "${HOME}/.shrc.d"/*; do
    case "${rc}" in
        *.sh|*.zsh)
            . "${rc}"
            ;;
    esac
done

if [ -d "${HOME}/.shrc.d/$(hostname).d" ]; then
    for rc in "${HOME}/.shrc.d/$(hostname).d"/*; do
        case "${rc}" in
            *.sh|*.zsh)
                . "${rc}"
                ;;
        esac
    done
fi
