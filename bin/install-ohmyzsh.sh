#!/bin/bash
[[ -x `which zsh` ]] || (echo "ZSH not found.  You must install it first." && exit 1)
curl -L http://install.ohmyz.sh | sh
echo "Oh-my-zsh installed.  Please see https://github.com/robbyrussell/oh-my-zsh for more information."

