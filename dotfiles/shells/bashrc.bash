# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case ${-} in
    *i*) ;;
      *) return;;
esac

if grep -iq ubuntu </proc/version; then
    . "${HOME}/.profile"
fi

for rc in $(ls "${HOME}/.shrc.d"); do
    case "${rc}" in
        *.sh|*.bash)
            . "${HOME}/.shrc.d/${rc}"
            ;;
    esac
done

if [ -d "${HOME}/.shrc.d/$(hostname).d" ]; then
    for rc in $(ls "${HOME}/.shrc.d/$(hostname).d"); do
        case "${rc}" in
            *.sh|*.bash)
                . "${HOME}/.shrc.d/$(hostname).d/${rc}"
                ;;
        esac
    done
fi
