#!/bin/bash

alias master='git checkout master && git pull'
alias masterr='git stash && git checkout master && git pull && git stash apply'
alias squash='git rebase -i $(git merge-base master HEAD)'
