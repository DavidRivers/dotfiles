#!/usr/bin/env bash
# https://github.com/scooter-dangle/dotfiles/blob/master/build_env.sh
# possible test for osx (if merging with other *nix scripts): if-shell 'test "$(uname)" = "Darwin"' 'source ~/.tmux-osx.conf'
# if-shell 'which >/dev/null 2>&1 reattach-to-user-namespace' 'source ~/.tmux-osx.conf'

## Need to automate association of GitHub SSH identity
# 1: check if there is an ssh identity
  # YES: prompt whether to use this identity for cloning ~/Dev dependencies from GitHub
  # NO: prompt user to create a new ssh identity
  # 2: upload new (or pre-existing) ssh identity to github settings
# 3: save name and email to global git config
# 4: use ssh identity to clone dotfiles (and save to ssh-agent, etc., if necessary)

## userland utils

brew install coreutils fish tmux reattach-to-user-namespace git vim
brew cask install flux divvy firefox google-chrome vlc
# add brews for other dev stacks (rvm, nvm, python/virtualenv?, browserify, etc.)
# maybe create manifest files that specify the dev stacks that a project requirest?

## Terminal.app configs

open -b 'com.apple.Terminal' "https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal"
open -b 'com.apple Terminal' "https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.termina://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.terminal"

## pull dotfiles

mkdir -p ~/Dev
git clone git@github.com:DavidRivers/dotfiles ~/Dev/dotfiles
ln -s ~/Dev/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/fish/
ln -s ~/Dev/dotfiles/config.fish ~/.config/fish/
ln -s ~/Dev/dotfiles/aliases.fish ~/.config/fish/aliases.fish
ln -s ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf

## fish configs

mkdir -p ~/.config/fish/completions
curl https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish --output ~/.config/fish/completions/tmuxinator.fish

## vim config

git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive && vim -u NONE -c "helptags vim-fugitive/doc" -c q
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized


## launch windows (start workflow)

open -a Firefox && osascript -e 'tell application "System Events" to keystroke "h" using {command down, option down}'
open -a Terminal && osascript -e 'tell application "System Events" to keystroke "l" using {command down, option down, control down}'
