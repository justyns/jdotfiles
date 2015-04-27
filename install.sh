#/bin/bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
# Last Updated: 07/15/2012
#
# Script to link my dot files and configs to where they belong
. bash/colors

#Check and see if these commands exist on the system
reqcommands="vim git ruby screen tmux mutt pyflakes hg ack ag ctags flake8"
for com in $reqcommands;
do
	hash ${com} 2>&- || echo -e >&2 "${RedF}${com}${reset}: not installed"
done


dotdir=$(pwd)
ignore="README.md .git install.sh bin update.sh misc"
for file in *; 
do
    if [[ "$ignore" =~ "$file" ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/.$file ] && [ ! -L $HOME/.$file ]; then
            echo -e "${RedF}$file${reset}: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi
        if [ -h $HOME/.$file ]; then
            echo -e "${GreenF}.$file${reset}: symlink exists"
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
            echo -e "${GreenF}bin/$file${reset}: symlink exists"
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

