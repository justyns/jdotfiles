#!/bin/bash
# https://github.com/syl20bnr/spacemacs
# http://spacemacs.org/

[[ -f ~/.emacs.d ]] && mv ~/.emacs.d-backup-$(date +%s)

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
