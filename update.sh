#!/usr/bin/env bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
#
# Script that updates the files from my jdotfiles repo and also updates all git submodules
# https://github.com/justyns/jdotfiles

# Assumes we are already in the location of .jdotfiles
# To update git submodules to their latest version:
#   git submodule foreach git pull origin master
#   git commit -a

echo "Updating main repo"
git pull
# Makes sure the submodules are the pinned commits
echo "Restoring pinned submodules"
git submodule update --init --recursive
echo "Re-running install.sh"
./install.sh
echo "Updating vim plugins"
vim +PlugUpdate +qall
echo "Cleaning old plugins"
vim +PlugClean +qall
