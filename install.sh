#/bin/bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
# Last Updated: 11/08/2011
#
# Script to link my dot files and configs to where they belong


dotdir=$(pwd)
ignore="README.md .git install.sh"
. bash/colors
for file in *; 
do
    if [[ "$ignore" =~ "$file" ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/.$file ] && [ ! -L $HOME/.$file ] && [ -d $HOME/.$file ]; then
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
