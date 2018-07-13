#!/usr/bin/env bash

code_path_linux="$HOME/.config/Code/User"
code_path_mac="$HOME/Library/Application Support/Code/User"
code_path=""

if [ ! -x "$(command -v code)" ] && [[ "$OSTYPE" == "darwin"* ]]; then
    brew cask install visual-studio-code
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    code_path="$code_path_linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    code_path="$code_path_mac"
fi

mkdir -p $code_path
if [ ! -L "$code_path/settings.json" ]; then
    if [ -f "$code_path/settings.json" ]; then
        rm "$code_path/settings.json"
    fi
    ln -s "$HOME/dotfiles/vscode.json" "$code_path/settings.json"
fi
