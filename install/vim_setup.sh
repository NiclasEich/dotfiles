#!/usr/bin/env bash

# Creating .vim directory
VIMDIR=$HOME/.vim
if [ -e "$VIMDIR" ]; then
    echo "~$VIMDIR already exists... Skipping."
else
    echo "Creating directory $VIMDIR"
    mkdir $VIMDIR
fi

# Crating symlink for the plugin-file
file=$HOME/.dotfiles/vim/plugins.vim
target="$VIMDIR/plugins.vim"
if [ -e "$target" ]; then
    echo "~${target#$HOME} already exists... Skipping."
else
    echo "Creating symlink for $file"
    ln -s "$file" "$target"
fi

# Cloning the Vundle-Repository as a plugin-manager
vundle_target="$HOME/.vim/bundle/Vundle.vim"
if [ -e "$vundle_target" ]; then
    echo "$vundle_target already exists... Skipping."
else
    echo "Cloning Vundle-Repo from git into $vundle_target"
    git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_target"
fi

# Running VundleUpdate to install all plugins
echo "Installing all VimPlugins with Vundle"
vim -c VundleUpdate -c quitall

# set up for UltiSnips
mkdir -p ~/.vim/ftdetect/
ln -s ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect/

# YouCompleteMe setup
python3 ~/.vim/bundle/YouCompleteMe/install.py

# Create nvim setup
mkdir $HOME/.config/nvim
echo "set runtimepath^=/.vim runtimepath+=~/.vim/after\nlet &packpath = &runtimepath\nsource ~/.vimrc" >> $HOME/.config/nvim/init.vim
