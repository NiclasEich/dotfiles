#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename "$file" '.symlink' )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s "$file" "$target"
    fi
done
touchables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.touch' )
for file in $touchables ; do
    target="$HOME/.$( basename "$file" '.touch' )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating $file"
        touch "$target"
    fi
done
