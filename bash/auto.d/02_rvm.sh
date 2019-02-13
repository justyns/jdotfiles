# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d $HOME/.rvm/bin ]] && export PATH="$PATH:$HOME/.rvm/bin"

# Source rvm functions if they exist
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
