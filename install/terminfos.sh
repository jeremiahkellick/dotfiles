#!/usr/bin/env bash

terminfos=$(ls ~/.terminfo/*/*)

if [[ ! $terminfos = *"italic"* ]]; then
    path1=~/dotfiles/install/terminfos/xterm-256color-italic.terminfo
    path2=~/dotfiles/install/terminfos/tmux-256color.terminfo
    tic -x $path1
    tic -x $path2
fi

