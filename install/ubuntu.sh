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
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/
git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/ && \
  vim -u NONE -c "helptags vim-fugitive/doc" -c q
