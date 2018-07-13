#!/usr/bin/env bash

brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install"

if [[ "$OSTYPE" == "darwin"* ]] && [ ! -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL $brew_url)"
fi
