#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]] && [ ! -x "$(command -v brew)" ]; then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
