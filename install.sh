#!/usr/bin/env bash

install_rbenv=false
install_node=false
install_vscode=false
install_test=false

read -p "Would you like to install rbenv [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_rbenv=true
fi

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

read -p "Would you like to install test [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_test=true
fi

source install/symlink.sh
source install/brew.sh
source install/update.sh
source install/curl.sh
source install/tmux.sh
source install/vim.sh

if [ "$install_rbenv" = true ]; then
  source install/rbenv.sh
fi

if [ "$install_node" = true ]; then
  source install/node.sh
fi

if [ "$install_vscode" = true ]; then
  source install/vscode.sh
fi

if [ "$install_test" = true ]; then
  echo "TEST"
fi

source install/terminfos.sh
