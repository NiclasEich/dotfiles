#!/usr/bin/env bash

echo -e "\\n\\nInstalling apt packages..."
echo "=============================="

formulas=(
    build-essential
    cmake
    curl
    git
    python3
    python3-dev
    silversearcher-ag
    sshfs
    tmux
    vim
    neovim
    python3-neovim
    wget
    zsh
)


apt-get update

for formula in "${formulas[@]}"; do
    formula_name=$( echo "$formula" | awk '{print $1}' )
    yes | apt-get install "$formula"
done

echo -e "\\n\\nInstalling oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ -d "~/.nerd-fonts"]; then
    echo -e "\\n\\nInstalling nerd-fonts"
    git clone https://github.com/ryanoasis/nerd-fonts ~/.nerd-fonts
    ~/.nerd-fonts/install.sh
fi

echo -e "\\n\\nRunning fzf installation"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

