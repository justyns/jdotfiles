# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "$HOME/.config/omf"

set -gx PATH $PATH ~/bin
set -gx PATH $PATH ~/go/bin
set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh
set -gx GOPATH $HOME/go

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Python virtual envs
eval (python3 -m virtualfish)
