#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install -y dconf-cli
fi
wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh && rm gogh
