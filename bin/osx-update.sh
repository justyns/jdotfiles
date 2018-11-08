#!/bin/bash

set -x

echo "Updating brew"
brew update; brew upgrade;
echo "Updating brew cask"
brew cask outdated; # brew cask upgrade
echo "Cleaning up brew and brew cask"
brew cleanup;brew cask cleanup

echo "Updating my dotfiles"
cd ~/.jdotfiles/ && ./update.sh

echo "Updating oh my fish"
if [ -x `which fish` ]; then
    fish -c 'omf update'
    fish -c fish_update_completions
fi

echo "Updating oh-my-zsh"
if [[ ! -z "$ZSH" ]]; then
    upgrade_oh_my_zsh
fi

echo "Updating atom"
if [ -x `which apm` ]; then
    apm update --confirm=false
fi

echo "Updating OSX"
softwareupdate -i -a
