#!/bin/bash

# Must be executing in repository root
cd $(dirname $0)

ln -f -s $(pwd)/zshrc ~/.zshrc
ln -f -s $(pwd)/vimrc ~/.vimrc
ln -f -s $(pwd)/tmux.conf ~/.tmux.conf
