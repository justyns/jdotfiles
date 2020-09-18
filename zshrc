# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# switched to spaceship on 02/11/2019
ZSH_THEME="spaceship"
# autoload -U promptinit; promptinit
# prompt spaceship
# vv this one looks like my fish prompt
# ZSH_THEME="bira"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  # gpg-agent
  # keychain
  ssh-agent
  # aws
  docker
  fzf
  gcloud
  iterm2
  terraform
  virtualenvwrapper
  kubectl
  # kube-ps1
  # rvm
  z
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source any executable files in ~/.bash/auto.d/*.sh
for file in $HOME/.bash/auto.d/*; do
    [ -x $file ] && . $file
done

# Source .bashrc.local if it exists(Can be used to override settings on a per-machine basis)
[[ -f $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

# Source .zshrc.local if it exists(Can be used to override settings on a per-machine basis)
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# kube-ps1 prompt
export KUBE_PS1_SYMBOL_USE_IMG=true
# export PROMPT='$(kube_ps1)'$PROMPT
#
# TODO: Move this
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Store pipenv virtualenvs in the project directory, helps with emacs autocompletion
export PIPENV_VENV_IN_PROJECT=1

# Use pyenv for multiple python versions
[[ -x $(which pyenv) ]] && eval "$(pyenv init -)"

# for gcloud
CLOUD_SDK_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ -d ${CLOUD_SDK_HOME} ]] && source "${CLOUD_SDK_HOME}/path.zsh.inc"
[[ -d ${CLOUD_SDK_HOME} ]] && source "${CLOUD_SDK_HOME}/completion.zsh.inc"

[[ -x $(which jira) ]] && eval "$(jira --completion-script-zsh)"

# Completion for stern
[[ -x $(which stern) ]] && source <(stern --completion=zsh)

# Cache terraform provider/plugin binaries
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Shortcuts to move by word with alt + left/right arrow
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# See https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh for what oh-my-zsh sets automatically
export HISTFILESIZE=10000000
export HISTSIZE=10000000

# Show kubectl context in spaceship prompt
[[ -x $(which kubectl) ]] && export SPACESHIP_KUBECTL_SHOW=true
