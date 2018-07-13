#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install -y dconf-cli
fi
wget -O xt  https://git.io/v5m1l && chmod +x xt && ./xt && rm xt
