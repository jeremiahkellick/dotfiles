#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get update
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew update
fi
