#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

source install/link.sh


# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on macOS"

    source install/brew.sh

    source install/osx.sh
elif [ "$(uname)" == "Linux" ]; then
    echo -e "\\n\\nRunning on Linux"

    source install/apt.sh
fi

if ! command_exists vim; then
    echo "Vim not found. Please install and re-run installation!"
fi
if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

source install/vim_setup.sh
