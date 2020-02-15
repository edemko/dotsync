# FIXME why is this not in .profile, or somewhere otherwise better?
# default editor setup
# export EDITOR=/usr/bin/vim
# export VISUAL=/usr/bin/subl

if ! echo "${PATH}" | grep -q "/home/okuno/Programs/kotlin/kotlinc/bin"; then
    export PATH="${PATH}:/home/okuno/Programs/kotlin/kotlinc/bin"
fi
if ! echo "${PATH}" | grep -q "/home/okuno/Programs/pakcs/pakcs-2.0.1/bin"; then
    export PATH="${PATH}:/home/okuno/Programs/pakcs/pakcs-2.0.1/bin"
fi
if ! echo "${PATH}" | grep -q "/home/okuno/.nix-profile/bin"; then
    export PATH="/home/okuno/.nix-profile/bin:${PATH}"
fi
