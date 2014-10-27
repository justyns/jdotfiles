#!/bin/bash
[[ -x `which fish` ]] || (echo "Fish not found.  You must install it first." && exit 1)
curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish
echo "Oh-my-fish installed.  Please see https://github.com/bpinto/oh-my-fish for more information."
