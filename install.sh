#!/usr/bin/env bash

install_node=false
install_vscode=false

read -p "Would you like to install node [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_node=true
fi

read -p "Would you like to install vscode [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_vscode=true
fi

source install/symlink.sh
source install/brew.sh
source install/update.sh
source install/curl.sh
source install/tmux.sh
source install/vim.sh

if [ "$install_node" = true ]; then
    source install/node.sh
fi

if [ "$install_vscode" = true ]; then
    source install/vscode.sh
fi

source install/terminfos.sh
