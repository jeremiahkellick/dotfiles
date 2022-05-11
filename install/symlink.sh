#!/usr/bin/env bash

DOTFILES=$HOME/dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename "$file" '.symlink' )"
    if [ -L "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        if [ -f "$target" ]; then
            rm "$target"
        fi
        if [ -d "$target" ]; then
            rm -r "$target"
        fi
        echo "Creating symlink for $file"
        ln -s "$file" "$target"
    fi
done
