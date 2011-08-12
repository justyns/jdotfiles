# Author: Justyn Shull < justyn [at] justynshull.com >
# Last Updated:  08/11/2011

# Stop here if we're in a non-interactive shell
[[ $- != *i* ]] && return

# Source global definitions if they exist
[[ -f /etc/bashrc ]] && . /etc/bashrc


# ### Bash History ###
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# If you want to ignorespace as well:
# HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Source color definitions
[[ -f $HOME/.bash/colors ]] && source $HOME/.bash/colors

# ### PROMPT ###
export PS1="\[\033[01;32m\][\u@\h\[\033[01;34m\] \w ]$\[\033[00m\]"

