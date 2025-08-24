# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.deno/bin:$HOME/.krew/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# switched to spaceship on 02/11/2019
# ZSH_THEME="spaceship"
# switched from spaceship to powerlevel10k on 10/28/2021
ZSH_THEME="powerlevel10k/powerlevel10k"
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
DISABLE_AUTO_TITLE="true"

# SSH function that auto-names tmux window
ssh() {
    if [[ -n "$TMUX" ]]; then
        # Extract hostname from ssh arguments (basic parsing)
        local host=$(echo "$@" | sed 's/.*@//; s/ .*//')
        tmux rename-window "ssh:$host"
        command ssh "$@"
        tmux set-window-option automatic-rename on
    else
        command ssh "$@"
    fi
}

# Atuin + fzf integration for history search
atuin-fzf-history() {
    local selected
    local query="$BUFFER"

    if [[ -n "$TMUX" ]]; then
        # Use tmux popup if inside tmux
        selected=$(atuin search --cmd-only "$query" | fzf --tmux=80%,60% --tac --no-sort --query="$query")
    else
        # Use regular fzf outside tmux
        selected=$(atuin search --cmd-only "$query" | fzf --tac --no-sort --query="$query")
    fi

    if [[ -n "$selected" ]]; then
        BUFFER="$selected"
        CURSOR=$#BUFFER
    fi
    zle reset-prompt
}
zle -N atuin-fzf-history

# TODO: Move tmux session stuff to a different file
# tmux session switcher with fzf
tmux-switch-session() {
    if [[ -z "$TMUX" ]]; then
        echo "Not in tmux session"
        return 1
    fi

    local selected
    selected=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows#{?session_attached, (attached),}" | \
        fzf --tmux=80%,60% --prompt="Switch to session: " | \
        cut -d: -f1)

    if [[ -n "$selected" ]]; then
        tmux switch-client -t "$selected"
    fi
}

# tmux window switcher with fzf
tmux-switch-window() {
    if [[ -z "$TMUX" ]]; then
        echo "Not in tmux session"
        return 1
    fi

    local selected
    selected=$(tmux list-windows -F "#{window_index}: #{window_name}#{?window_active, (active),}" | \
        fzf --tmux=80%,60% --prompt="Switch to window: " | \
        cut -d: -f1)

    if [[ -n "$selected" ]]; then
        tmux select-window -t "$selected"
    fi
}

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
  evalcache
  # gpg-agent
  # keychain
  ssh-agent
  # aws
  docker
  fzf
  # gcloud
  iterm2
  # terraform
  # virtualenvwrapper
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

# Source .bashrc.local if it exists (Can be used to override settings on a per-machine basis)
[[ -f $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

# Source .zshrc.local if it exists (Can be used to override settings on a per-machine basis)
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Enable archlinux only if we're on arch or endeavouros
[[ -x $(which pacman) ]] && plugins+=(archlinux)
[[ -x $(which uv) ]] && plugins+=(uv)
[[ -x $(which mise) ]] && plugins+=(mise)

# kube-ps1 prompt
export KUBE_PS1_SYMBOL_USE_IMG=true
# export PROMPT='$(kube_ps1)'$PROMPT

# Store pipenv virtualenvs in the project directory, helps with emacs autocompletion
export PIPENV_VENV_IN_PROJECT=1

# Use pyenv for multiple python versions
# TODO: Use mise instead of pyenv?
[[ -x $(which pyenv) ]] && _evalcache pyenv init -

# for gcloud
CLOUD_SDK_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ -d ${CLOUD_SDK_HOME} ]] && source "${CLOUD_SDK_HOME}/path.zsh.inc"
[[ -d ${CLOUD_SDK_HOME} ]] && source "${CLOUD_SDK_HOME}/completion.zsh.inc"

[[ -x $(which jira) ]] && _evalcache jira --completion-script-zsh

# Completion for stern
[[ -x $(which stern) ]] && source <(stern --completion=zsh)

# python uv
[[ -x $(which uv) ]] && _evalcache uv generate-shell-completion zsh

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Cache terraform provider/plugin binaries
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

export ANONYMIZED_TELEMETRY=false

# Shortcuts to move by word with alt + left/right arrow
# Works with most modern terminals including iTerm2 on macOS, and ghostty/konsole on linux
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# Bind Ctrl+R to atuin-fzf history search
bindkey '^R' atuin-fzf-history

# See https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh for what oh-my-zsh sets automatically
export HISTFILESIZE=10000000
export HISTSIZE=10000000

# See https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt EXTENDED_HISTORY

# Show kubectl context in spaceship prompt
# [[ -x $(which kubectl) ]] && export SPACESHIP_KUBECTL_SHOW=true
# export SPACESHIP_KUBECTL_SHOW=false

# See https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92 - only regenerates completion once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Trying out Mise - https://mise.jdx.dev/getting-started.html
[[ -x $(which mise) ]] && _evalcache mise activate zsh

# atuin - zsh history, only bind to ctrl+r and sync history, dont take over the up arrow
[[ -x $(which atuin) ]] && _evalcache atuin init zsh --disable-up-arrow
