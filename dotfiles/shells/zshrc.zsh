for rc in $(ls "${HOME}/.shrc.d"); do
    case "${rc}" in
        *.sh|*.zsh)
            . "${HOME}/.shrc.d/${rc}"
            ;;
    esac
done

if [ -d "${HOME}/.shrc.d/$(hostname).d" ]; then
    for rc in $(ls "${HOME}/.shrc.d/$(hostname).d"); do
        case "${rc}" in
            *.sh|*.zsh)
                . "${HOME}/.shrc.d/$(hostname).d/${rc}"
                ;;
        esac
    done
fi
