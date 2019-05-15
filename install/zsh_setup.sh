#!/usr/bin/env bash
ZSH_CUSTOM=$HOME/.dotfiles/zsh
TARGET_ZSH=$HOME/.oh-my-zsh/custom

echo -e "Linking Custom ZSH themes"
echo "=============================="
linkables=$( find -H "$ZSH_CUSTOM/themes" -name '*.zsh-theme')
if [ -e "$TARGET_ZSH" ]; then
    for file in $linkables ; do
        target="$TARGET_ZSH/themes/$( basename "$file")"
	echo $target
        if [ -e "$target" ]; then
        	echo "~${target#$HOME} already exists... Skipping."
        else
        	echo "Creating symlink for $file"
        	ln -s "$file" "$target"
        fi
    done
else
    echo -e "Oh-my-zsh not installed!"
fi
