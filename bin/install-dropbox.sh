#!/bin/bash
# Justyn Shull https://github.com/justyns/jdotfiles
# Extremely simple script, but makes it so I dont have to remember to go to the dropbox website and find the link to download
# Does not include an init script.

cd $HOME
if [ `getconf LONG_BIT` == '64' ];
then
	echo "Downloading 64bit dropbox..";
	wget -O - http://www.dropbox.com/download?plat=lnx.x86_64 | tar xzf -
else
	echo "Downloading 32bit dropbox..";
	wget -O - http://www.dropbox.com/download?plat=lnx.x86 | tar xzf -
fi
echo "Go to the link when asked..   Then ctrl+c and use dropbox.py start to start the dropbox daemon.   Setup init script if wanted"
~/.dropbox-dist/dropboxd
