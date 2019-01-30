#!/usr/bin/env bash

if [ ! -x "$(command -v tmux)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get -y install tmux
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    fi
fi
