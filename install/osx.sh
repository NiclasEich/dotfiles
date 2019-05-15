#!/usr/bin/env bash

echo -e "\\n\\nSetting OS X settings"
echo "=============================="

echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true
