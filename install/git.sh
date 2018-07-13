#!/usr/bin/env bash

if [ ! -x "$(command -v git)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get install git
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install git
    fi
fi
