#!/usr/bin/env bash

if [ ! -x "$(command -v nvm)" ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh \
        | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
fi
