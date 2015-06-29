cd ~
git clone https://github.com/DavidRivers/dotfiles

ln -s dotfiles/vimrc .vimrc
mkdir --parents ~/.config/fish && ln -s dotfiles/config.fish ~/.config/fish/
