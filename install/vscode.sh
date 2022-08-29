#!/usr/bin/env bash

if [ ! -x "$(command -v code)" ] && [[ "$OSTYPE" == "darwin"* ]]; then
    brew cask install visual-studio-code
fi

code_path=""
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    code_path="$HOME/.config/Code/User"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    code_path="$HOME/Library/Application Support/Code/User"
fi

files=$( find -H "$HOME/dotfiles/vscode" -maxdepth 8 -type f )

mkdir -p $code_path
for file in $files ; do
    target="$code_path/$( basename "$file" )"
    if [ ! -L "$target" ]; then
        if [ -f "$target" ]; then
            rm "$target"
        fi
        ln -s "$file" "$target"
    fi
done
