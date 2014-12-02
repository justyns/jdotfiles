Justyns dotfiles
=================

Description
-----------
This is a collection of various configs(dotfiles) I like to use in my shells

Installation
-----------
    cd
    git clone git@github.com:justyns/jdotfiles.git .jdotfiles
    cd .jdotfiles
    git submodule init
    git submodule update
    ./install.sh
    ./update.sh
If any files or directories exist already, move them out of the way and re-run install.sh

Updates
-------
    cd ~/.jdotfiles
    ./update.sh

Updating submodules
-------------------
If you want to update the git submodules to a commit newer than what is referenced in this git repo, you can by running this:

    git submodule foreach git pull origin master

You can then commit the changes to update the submodule metadata

iTerm Solarized
===============
Download the iterm2 solarized colors here: https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
