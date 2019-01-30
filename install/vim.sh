#!/usr/bin/env bash

if [ ! -x "$(command -v vim)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get -y install vim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install vim
    fi
fi
