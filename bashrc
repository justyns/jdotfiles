# Author: Justyn Shull < justyn [at] justynshull.com >
# Last Updated:  08/11/2011

# Stop here if we're in a non-interactive shell
[[ $- != *i* ]] && return

# Same as above, but a allows emacs tramp mode to work
if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

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

# Source pass auto-complete
[[ -f $HOME/.bash/pass.bash-completion ]] && source $HOME/.bash/pass.bash-completion

# Set VIM as the editor
export EDITOR="vim"
export VISUAL="$EDITOR"

# ### PROMPT ###
export PS1="\[\033[01;32m\][\u@\h\[\033[01;34m\] \w ]$\[\033[00m\]"

# Source any executable files in ~/.bash/auto.d/*.sh
for file in $HOME/.bash/auto.d/*; do
    [ -x $file ] && . $file
done

# Source .bashrc.local if it exists(Can be used to override settings on a per-machine basis)
[[ -f $HOME/.bashrc.local ]] && source $HOME/.bashrc.local


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"  # Mostly used by pip
