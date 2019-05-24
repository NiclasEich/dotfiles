#!/usr/bin/env bash

echo -e "\\n\\nSetting OS X settings"
echo -e "=============================="

echo -e "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

echo -e "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo -e "Install iterm2 zsh integration"
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
