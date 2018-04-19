#!/usr/bin/env bash

sudo apt-get install -y dconf-cli
wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh && rm gogh

source install/symlink.sh

