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

If any files or directories exist already, move them out of the way and re-run install.sh

Note: If a file or directory is already a symlink, but the symlink points to something else or is invalid, it will be overwritten.

Updates
-------
    cd ~/.jdotfiles
    ./update.sh

Updating submodules
-------------------
If you want to update the git submodules to a commit newer than what is referenced in this git repo, you can by running this:

    git submodule foreach git pull origin master

You can then commit the changes to update the submodule metadata

UI Themes and customizations
============================

Terminals
---------

Iterm 2
-------

Download catppuccin theme here (I usually use Frappé): https://github.com/catppuccin/iterm

Iterm configuration:
- CMD+O to open profiles, edit profiles, edit default
- go to colors, color presets -> import
- go to keys, change Left option key to "Esc+" and check "Apps can change this"
- Right option key leave on "Normal"
- go to Terminal, change scrollback history to something like 50,000, set terminal type to xterm-256color
- go to Text, change font to Hack Nerd Font Mono / Regular / 14pt

Ghostty
-------

Download ghostty following: https://ghostty.org/download

Install catpuccin theme from: https://github.com/catppuccin/ghostty

Editors
-------

Atom Flatland theme (to match monokai): https://atom.io/themes/flatland

Vim: [space-vim-dark](https://github.com/liuchengxu/space-vim-dark)

Shells
------

ZSH theme: [powerlevel10k](https://github.com/romkatv/powerlevel10k)

Fonts
-----

Input font (based on Monaco settings): [http://input.fontbureau.com](http://input.fontbureau.com/preview/?size=15&language=python&theme=monokai&family=InputMono&width=300&weight=300&line-height=1.2&a=0&g=ss&i=serif&l=serifs&zero=slash&asterisk=0&braces=0&preset=monaco&customize=please)

2019/02/25: Since I started using [vim-devicons](https://github.com/ryanoasis/vim-devicons#character-mappings), I switched to using [Nerd Font's](https://github.com/ryanoasis/nerd-fonts) version of Hack.  It can be installed with: `brew tap caskroom/fonts && brew cask install font-hack-nerd-font`

Misc
----

OSX Menumeters: http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/
