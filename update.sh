#!/bin/bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
# Last Updated: 05/14/2014
#
# Script that updates the files from my jdotfiles repo and also updates all git submodules
# https://github.com/justyns/jdotfiles

# Assumes we are already in the location of .jdotfiles
# To update git submodules to their latest version:
#   git submodule foreach git pull origin master
#   git commit -a

echo "Updating main repo"
git pull
echo "Updating git submodules"
git submodule init
git submodule update
echo "Re-running install.sh"
./install.sh
