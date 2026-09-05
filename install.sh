#!/usr/bin/env bash
# Author:  Justyn Shull < justyn [at] justynshull.com >
#
# Script to link my dot files and configs to where they belong
. bash/colors

create_symlinks() {
    local source_dir="$1"
    local target_dir="$2"
    local ignore_patterns="$3"
    local display_prefix="$4"
    local add_dot_prefix="$5"

    cd "$source_dir"
    mkdir -pv "$target_dir"

    for file in *; do
        if [[ "$ignore_patterns" =~ "$file" ]] || [[ "$file" == *.md ]]; then
            continue
        fi

        local target_file="$target_dir/$file"
        if [[ "$add_dot_prefix" == "true" ]]; then
            target_file="$target_dir/.$file"
        fi
        local expected_target="$source_dir/$file"

        if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
            echo -e "${RedF}${display_prefix}$file${reset}: Exists but not a symlink. You should backup and delete(or move) it."
            continue
        fi

        if [ -h "$target_file" ]; then
            local current_target=$(readlink "$target_file")
            if [ "$current_target" = "$expected_target" ] && [ -e "$target_file" ]; then
                echo -e "${GreenF}${display_prefix}$file${reset}: symlink exists and is correct"
            else
                if [ ! -e "$target_file" ]; then
                    echo -e "${RedF}${display_prefix}$file${reset}: symlink is broken (target doesn't exist). Removing and recreating."
                else
                    echo -e "${YellowF}${display_prefix}$file${reset}: symlink points to wrong location ($current_target vs $expected_target). Removing and recreating."
                fi
                rm "$target_file"
                echo -e "${YellowF}${display_prefix}$file${reset}: Linking to ${BoldOn}$target_file${reset}"
                ln -s "$expected_target" "$target_file"
            fi
        else
            if [ -d "$target_file" ]; then
                echo -e "${RedF}${display_prefix}$file${reset}: is a directory. You should backup and delete(or move) it."
            else
                echo -e "${YellowF}${display_prefix}$file${reset}: Linking to ${BoldOn}$target_file${reset}"
                ln -s "$expected_target" "$target_file"
            fi
        fi
    done
}

#Check and see if these commands exist on the system
reqcommands="vim nvim git python tmux rg ctags zsh bat editorconfig mise uv"
for com in $reqcommands;
do
	hash ${com} 2>&- || echo -e >&2 "${RedF}${com}${reset}: not installed"
done


dotdir=$(pwd)

echo "Initialising plugin submodules"
git submodule update --init --recursive
for sub in $(git config -f .gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $2}'); do
    if [ -z "$(ls -A "$dotdir/$sub" 2>/dev/null)" ]; then
        echo -e "${RedF}$sub${reset}: submodule is empty"
    fi
done

create_symlinks "$dotdir" "$HOME" ".git install.sh bin update.sh misc .config tags zsh-custom" "." "true"
# TODO: Migrate to ~/.local/bin ?
create_symlinks "$dotdir/bin" "$HOME/bin" ".git install.sh bin" "bin/" "false"
# walker/elephant/rofi are Linux-only, installed by bin/setup-walker
config_ignore=".gitkeep"
if ! hash pacman 2>&-; then
    config_ignore="$config_ignore walker elephant rofi"
fi
create_symlinks "$dotdir/config" "$HOME/.config" "$config_ignore" ".config/" "false"

# Install oh-my-zsh and extra plugins/themes
echo "Installing oh-my-zsh and plugins"
# [[ ! -d $HOME/.oh-my-zsh ]] && git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]; then
    [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom} ]] && mkdir -pv ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/{themes,plugins}

    create_symlinks "$dotdir/zsh-custom/plugins" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins" ".gitkeep" "zsh-custom/plugins/" "false"
else
    echo -e "Run this to install oh-my-zsh: \n  sh -c '\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"
fi

if [[ ! -f ~/.gitconfig.local ]]; then
    echo -e "${RedF}~/.gitconfig.local${reset}: Doesn't exist.  You should create it with something like: \n[user]\n\tname = Justyn Shull\n\temail = git@justyn.io\n";
else
    echo -e "${GreenF}~/.gitconfig.local${reset}: exists"
fi

# I should probably split tasks like this into separate files

# Knife on windows or wsl is super slow, rehash causes it to cache the list of knife sub commands and speeds it up quite a bit
hash knife  2>&- && knife rehash

#echo "Installing and configuring home-manager"
# TODO: This is a WIP
#mkdir -pv ~/.config/home-manager
#mkdir -pv ${HOME}/.config/home-manager
#cd ${HOME}/.config/home-manager
#for x in ${dotdir}/home-manager/*;do
  #ln -sv "$x"
#done

if [[ -d $HOME/.local/share/konsole ]]; then
    echo -e "${GreenF}~/.local/share/konsole${reset}: exists"
    create_symlinks "$dotdir/config/konsole" "$HOME/.local/share/konsole" ".gitkeep catppuccin-frappe.colorscheme" "config/konsole/" "false"

    # Download Catppuccin Frappe theme
    echo "Downloading Catppuccin Frappe theme for Konsole"
    if [[ ! -f $HOME/.local/share/konsole/catppuccin-frappe.colorscheme ]]; then
        curl -fsSL "https://raw.githubusercontent.com/catppuccin/konsole/refs/heads/main/themes/catppuccin-frappe.colorscheme" \
            -o "$HOME/.local/share/konsole/catppuccin-frappe.colorscheme"
        echo -e "${GreenF}Catppuccin Frappe theme${reset}: downloaded"
    else
        echo -e "${GreenF}Catppuccin Frappe theme${reset}: already exists"
    fi
else
    echo -e "${YellowF}~/.local/share/konsole${reset}: directory doesn't exist, skipping Konsole config"
fi
