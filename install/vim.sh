#!/usr/bin/env bash

if [ ! -x "$(command -v vim)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get -y install vim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install vim
    fi
fi

if [[ $(vim --version | grep VIM) = *"7.4"* ]]; then
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get -y install vim
fi
