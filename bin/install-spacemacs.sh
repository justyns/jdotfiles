#!/bin/bash
# https://github.com/syl20bnr/spacemacs
# http://spacemacs.org/

[[ -f ~/.emacs.d ]] && mv ~/.emacs.d-backup-$(date +%s)

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

if [ -x $(which go) ]; then
    go get -u -v github.com/nsf/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v golang.org/x/tools/cmd/oracle
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/goimports
fi
