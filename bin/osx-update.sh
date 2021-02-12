#!/bin/bash

set -x
set -e

echo "Updating my dotfiles"
cd ~/.jdotfiles/ && ./update.sh

echo "Running brew bundle"
cd ~/.jdotfiles/ && brew bundle -v --no-upgrade

echo "Updating brew formula"
brew update
brew outdated --formula
brew upgrade --formula
echo "Updating brew cask"
brew outdated --cask
brew upgrade --cask --require-sha
echo "Cleaning up brew and brew cask"
brew cleanup

# 2020-05-01: I don't use fish anymore
# echo "Updating oh my fish"
# if [ -x `which fish` ]; then
#     fish -c 'omf update'
#     fish -c fish_update_completions
# fi

echo "Updating oh-my-zsh"
if [[ ! -z "$ZSH" ]]; then
    zsh -c upgrade_oh_my_zsh || echo "TODO: Why does this fail"
fi

# 2020-05-01: I don't really use atom anymore
# echo "Updating atom"
# if [ -x `which apm` ]; then
#     apm update --confirm=false
# fi

# 2020-05-01: Disabling this for now so that I can control this separately
# echo "Updating OSX"
# softwareupdate -i -a
