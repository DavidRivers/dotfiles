# https://github.com/scooter-dangle/dotfiles/blob/master/build_env.sh

cd ~
git clone https://github.com/DavidRivers/dotfiles

mkdir --parents .config/fish
ln --symbolic dotfiles/vimrc .vimrc
ln --symbolic dotfiles/config.fish ~/.config/fish/

cd ~
