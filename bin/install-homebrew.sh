#!/bin/bash
echo "Installing homebrew.."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installing homebrew caskroom"
brew install caskroom/cask/brew-cask
echo "Running brew doctor.  You should follow any advice it gives."
brew doctor

