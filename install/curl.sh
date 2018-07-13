#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]] && [ ! -x "$(command -v curl)" ]; then
    sudo apt-get install curl
fi
