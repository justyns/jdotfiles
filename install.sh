#/bin/bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
# Last Updated: 08/11/2011
#
# Script to link my dot files and configs to where they belong


dotdir=$(pwd)
ignore="README.md .git install.sh"
for file in *; 
do
    if [[ "$ignore" =~ "$file" ]]; then
        # ignore file
        echo -n
    else
        if [ -f $HOME/.$file ] && [ ! -L $HOME/.$file ]; then
            echo "$file: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi
        if [ -h $HOME/.$file ]; then
            echo "$file: symlink exists"
        else
            echo "$file: Linking to $HOME/.$file"
            ln -s $dotdir/$file $HOME/.$file
        fi
    fi
done
