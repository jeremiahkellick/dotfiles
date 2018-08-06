#!/usr/bin/env bash

if [ ! -x "$(command -v tmux)" ]; then
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		sudo apt-get -y install tmux
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		brew install tmux
	fi
fi
echo $(which tmux)
if [[ $(tmux -V) = *"2.1"* ]]; then
    echo "2"
    sudo apt-get -y remove tmux
	sudo apt-get install -y automake build-essential pkg-config libevent-dev
	sudo apt-get install -y libncurses5-dev
	rm -fr /tmp/tmux
	git clone https://github.com/tmux/tmux.git /tmp/tmux
	cd /tmp/tmux
    git checkout 2.7
	sh autogen.sh
	./configure && make
	sudo make install
	cd -
	rm -fr /tmp/tmux
    source ~/.bashrc
fi

cd ~/dotfiles
