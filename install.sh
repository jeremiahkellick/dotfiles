#!/usr/bin/env bash

cd $HOME/dotfiles

install_vscode=false
read -p "Would you like to install vscode [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_vscode=true
fi

update_package_manager=false
read -p "Would you like to update your package manager sources [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    update_package_manager=true
fi

source symlink.sh

# If macOS, install Homebrew
if [[ "$OSTYPE" == "darwin"* ]] && [ ! -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update package manager
if [ "$update_package_manager" = true ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get update
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew update
    fi
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

# Install unzip
if [[ "$OSTYPE" == "linux-gnu" ]] && [ ! -x "$(command -v unzip)" ]; then
    sudo apt-get -y install unzip
fi

# Install nvim
if [ ! -x "$(command -v nvim)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        nvim_name="nvim-linux64"
        nvim_version="v0.9.5"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        nvim_name="nvim-macos-arm64"
        nvim_version="nightly"
    fi
    cd $HOME
    curl -OL https://github.com/neovim/neovim/releases/download/$nvim_version/$nvim_name.tar.gz
    tar -xzf $nvim_name.tar.gz
    mkdir -p .local/bin
    ln -s $HOME/$nvim_name/bin/nvim .local/bin/nvim
    rm $nvim_name.tar.gz
    cd $HOME/dotfiles
fi

# Install packer.vim
if [ ! -d $HOME/.local/share/nvim/site/pack/packer ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
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
