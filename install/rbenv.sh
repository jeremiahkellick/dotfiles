#!/usr/bin/env bash

if [ ! -x "$(command -v rbenv)" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get update
        sudo apt-get install autoconf bison build-essential libssl-dev \
            libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev \
            libffi-dev libgdbm3 libgdbm-dev
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        cd ~/.rbenv
        git checkout tags/v1.1.1 -b v1.1.1
        git clone https://github.com/rbenv/ruby-build.git \
            ~/.rbenv/plugins/ruby-build
        cd ~/.rbenv/plugins/ruby-build
        git checkout tags/v20180424 -b v20180424
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install rbenv
        rbenv init
    fi
fi

if [ ! -d "~/.rbenv/plugins/rbenv-bundler" ]; then
    mkdir -p ~/.rbenv/plugins
    git clone https://github.com/carsomyr/rbenv-bundler \
        ~/.rbenv/plugins/rbenv-bundler
    cd ~/.rbenv/plugins/rbenv-bundler
    git checkout tags/1.00 -b 1.00
fi
