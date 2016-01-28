#!/bin/bash

# Install system dependencies
sudo apt-get install git fish

# Symlink configuration files
mkdir --parents ~/.config/fish
ln --symbolic ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln --symbolic ~/Dev/dotfiles/config.fish ~/.config/fish/
ln --symbolic ~/Dev/dotfiles/aliases.fish ~/.config/fish/aliases.fish
ln --symbolic ~/Dev/dotfiles/.vimrc ~/.vimrc

# Install vim dependencies
