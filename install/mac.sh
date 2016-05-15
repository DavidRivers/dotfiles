#!/usr/bin/env bash
# https://github.com/scooter-dangle/dotfiles/blob/master/build_env.sh

# userland utils

brew install coreutils fish tmux git vim
brew cask install flux divvy firefox google-chrome vlc

# Terminal.app configs

open -b 'com.apple.Terminal' "https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal"
open -b 'com.apple Terminal' "https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.termina://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.terminal"

# fish configs

mkdir -p ~/.config/fish/completions
curl https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish --output ~/.config/fish/completions/tmuxinator.fish
ln -s ~/dotfiles/config.fish ~/.config/fish/
ln -s ~/dotfiles/aliases.fish ~/.config/fish/aliases.fish

# vim config

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/DavidRivers/dotfiles ~/dotfiles
ln -s ~/dotfiles/.vimrc ~/.vimrc
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized


# launch windows (start workflow)
open -a Firefox && osascript -e 'tell application "System Events" to keystroke "h" using {command down, option down}'
open -a Terminal && osascript -e 'tell application "System Events" to keystroke "l" using {command down, option down, control down}'
