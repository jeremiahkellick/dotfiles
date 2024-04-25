#!/usr/bin/env bash

install_vscode=false
read -p "Would you like to install vscode [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_vscode=true
fi

source symlink.sh

# If macOS, install Homebrew
if [[ "$OSTYPE" == "darwin"* ]] && [ ! -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update package manager
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get update
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew update
fi

# Install curl
if [[ "$OSTYPE" == "linux-gnu" ]] && [ ! -x "$(command -v curl)" ]; then
    sudo apt-get -y install curl
fi

# Install tmux
if [ ! -x "$(command -v tmux)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get -y install tmux
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    fi
fi

# Install vim
if [ ! -x "$(command -v vim)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get -y install vim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install vim
    fi
fi

# If macOS, install terminfos
if [[ "$OSTYPE" == "darwin"* ]]; then
    terminfos=$(ls ~/.terminfo/*/*)

    if [[ ! $terminfos = *"italic"* ]]; then
        path1=~/dotfiles/terminfos/xterm-256color-italic.terminfo
        path2=~/dotfiles/terminfos/tmux-256color.terminfo
        tic -x $path1
        tic -x $path2
    fi
fi

if [ "$install_vscode" = true ]; then
    source vscode.sh
fi
