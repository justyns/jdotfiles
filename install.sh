#!env bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
# Last Updated: 07/15/2012
#
# Script to link my dot files and configs to where they belong
. bash/colors

#Check and see if these commands exist on the system
reqcommands="vim git python ruby screen tmux mutt pyflakes hg ack ag ctags flake8 go zsh bat editorconfig"
for com in $reqcommands;
do
	hash ${com} 2>&- || echo -e >&2 "${RedF}${com}${reset}: not installed"
done


dotdir=$(pwd)
ignore="README.md .git install.sh bin update.sh misc .config tags"
for file in *; 
do
    if [[ "$ignore" =~ "$file" ]] || [[ "$file" == *.md ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/.$file ] && [ ! -L $HOME/.$file ]; then
            echo -e "${RedF}$file${reset}: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi
        if [ -h $HOME/.$file ]; then
            # Check if symlink target exists and points to correct location
            current_target=$(readlink "$HOME/.$file")
            expected_target="$dotdir/$file"
            if [ "$current_target" = "$expected_target" ] && [ -e "$HOME/.$file" ]; then
                echo -e "${GreenF}.$file${reset}: symlink exists and is correct"
            else
                if [ ! -e "$HOME/.$file" ]; then
                    echo -e "${RedF}.$file${reset}: symlink is broken (target doesn't exist). Removing and recreating."
                else
                    echo -e "${YellowF}.$file${reset}: symlink points to wrong location ($current_target vs $expected_target). Removing and recreating."
                fi
                rm "$HOME/.$file"
                echo -e "${YellowF}$file${reset}: Linking to ${BoldOn}$HOME/.$file${reset}"
                ln -s "$dotdir/$file" "$HOME/.$file"
            fi
        else
	    if [ -d $HOME/.$file ]; then
		    echo -e "${RedF}.$file${reset}: is a directory. You should backup and delete(or move) it."
	    else
            	    echo -e "${YellowF}$file${reset}: Linking to ${BoldOn}$HOME/.$file${reset}"
                    ln -s $dotdir/$file $HOME/.$file
	    fi
        fi
    fi
done

#Link files in the ~bin directory
#TODO: make a function instead of copying/pasting the code above :)

ignore="README.md .git install.sh bin"
cd ${dotdir}/bin
mkdir -pv ${HOME}/bin
for file in *;
do
    if [[ "$ignore" =~ "$file" ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/bin/$file ] && [ ! -L $HOME/bin/$file ]; then
            echo -e "${RedF}$file${reset}: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi
        if [ -h $HOME/bin/$file ]; then
            # Check if symlink target exists and points to correct location
            current_target=$(readlink "$HOME/bin/$file")
            expected_target="$dotdir/bin/$file"
            if [ "$current_target" = "$expected_target" ] && [ -e "$HOME/bin/$file" ]; then
                echo -e "${GreenF}bin/$file${reset}: symlink exists and is correct"
            else
                if [ ! -e "$HOME/bin/$file" ]; then
                    echo -e "${RedF}bin/$file${reset}: symlink is broken (target doesn't exist). Removing and recreating."
                else
                    echo -e "${YellowF}bin/$file${reset}: symlink points to wrong location ($current_target vs $expected_target). Removing and recreating."
                fi
                rm "$HOME/bin/$file"
                echo -e "${YellowF}bin/$file${reset}: Linking to ${BoldOn}$HOME/bin/$file${reset}"
                ln -s "$dotdir/bin/$file" "$HOME/bin/$file"
            fi
        else
            if [ -d $HOME/bin/$file ]; then
                    echo -e "${RedF}bin/$file${reset}: is a directory. You should backup and delete(or move) it."
            else
                    echo -e "${YellowF}bin/$file${reset}: Linking to ${BoldOn}$HOME/bin/$file${reset}"
                    ln -s $dotdir/bin/$file $HOME/bin/$file
            fi
        fi
    fi
done

# Do the same for the config dir
# TODO: This should all really be moved into functions
# TODO: Migrate to ~/.local/bin ?
ignore="README.md .gitkeep"
cd ${dotdir}/config
mkdir -pv ${HOME}/.config
for file in *;
do
    if [[ "$ignore" =~ "$file" ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/.config/$file ] && [ ! -L $HOME/.config/$file ]; then
            echo -e "${RedF}$file${reset}: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi
        if [ -h $HOME/.config/$file ]; then
            # Check if symlink target exists and points to correct location
            current_target=$(readlink "$HOME/.config/$file")
            expected_target="$dotdir/config/$file"
            if [ "$current_target" = "$expected_target" ] && [ -e "$HOME/.config/$file" ]; then
                echo -e "${GreenF}.config/$file${reset}: symlink exists and is correct"
            else
                if [ ! -e "$HOME/.config/$file" ]; then
                    echo -e "${RedF}.config/$file${reset}: symlink is broken (target doesn't exist). Removing and recreating."
                else
                    echo -e "${YellowF}.config/$file${reset}: symlink points to wrong location ($current_target vs $expected_target). Removing and recreating."
                fi
                rm "$HOME/.config/$file"
                echo -e "${YellowF}.config/$file${reset}: Linking to ${BoldOn}$HOME/.config/$file${reset}"
                ln -s "$dotdir/config/$file" "$HOME/.config/$file"
            fi
        else
            if [ -d $HOME/.config/$file ]; then
                    echo -e "${RedF}.config/$file${reset}: is a directory. You should backup and delete(or move) it."
            else
                    echo -e "${YellowF}.config/$file${reset}: Linking to ${BoldOn}$HOME/config/$file${reset}"
                    ln -s $dotdir/config/$file $HOME/.config/$file
            fi
        fi
    fi
done

#echo "Installing youcompleteme for vim"
#cd ~/.vim/bundle/YouCompleteMe
#./install.py --clang-completer --gocode-completer
echo "Installing vim plugins"
vim +PlugInstall +qall

# Install oh-my-zsh and extra plugins/themes
echo "Installing oh-my-zsh and plugins"
# [[ ! -d $HOME/.oh-my-zsh ]] && git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]; then
    [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom} ]] && mkdir -pv ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/{themes,plugins}

    # Install spaceship
    [[ ! -d $HOME/.oh-my-zsh/custom/themes/spaceship-prompt ]] \
        && git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git $HOME/.oh-my-zsh/custom/themes/spaceship-prompt \
        && ln -sv $HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme

    # Install powerline10k
    [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache ]] && git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache
else
    echo -e "Run this to install oh-my-zsh: \n  sh -c '\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"
fi

if [[ ! -f ~/.gitconfig.local ]]; then
    echo -e "${RedF}~/.gitconfig.local${reset}: Doesn't exist.  You should create it with something like: \n[user]\n\tname = Justyn Shull\n\temail = git@justyn.io\n";
else
    echo -e "${GreenF}~/.gitconfig.local${reset}: exists"
fi

# I should probably split tasks like this into separate files

# Knife on windows or wsl is super slow, rehash causes it to cache the list of knife sub commands and speeds it up quite a bit
hash knife  2>&- && knife rehash

#echo "Installing and configuring home-manager"
# TODO: This is a WIP
#mkdir -pv ~/.config/home-manager
#mkdir -pv ${HOME}/.config/home-manager
#cd ${HOME}/.config/home-manager
#for x in ${dotdir}/home-manager/*;do
  #ln -sv "$x"
#done
