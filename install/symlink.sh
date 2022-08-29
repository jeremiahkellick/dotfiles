#!/usr/bin/env bash

linkables=$( find -H "$HOME/dotfiles" -maxdepth 3 -name '*.symlink' )

for file in $linkables ; do
    target="$HOME/.$( basename "$file" '.symlink' )"
    if [ ! -L "$target" ]; then
        if [ -f "$target" ]; then
            rm "$target"
        fi
        if [ -d "$target" ]; then
            rm -r "$target"
        fi
        ln -s "$file" "$target"
    fi
done
