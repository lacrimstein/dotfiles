#!/bin/bash

# This script symlinks the dotfiles into their respective locations in $HOME/.config
# Also downloads and installs TPM (Tmux Plugin Manager)

# On first run, press <C-a>I for TPM to install plugins specified in tmux.conf

mkdir -p ~/.config/nvim/
mkdir -p ~/.config/tmux/plugins/

ln -T ./nvim/init.lua ~/.config/nvim/init.lua
ln -T ./tmux/tmux.conf ~/.config/tmux/tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
