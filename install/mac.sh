# https://github.com/scooter-dangle/dotfiles/blob/master/build_env.sh

cd ~
git clone https://github.com/DavidRivers/dotfiles

curl https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish --output ~/.config/fish/completions/tmuxinator.fish

mkdir --parents .config/fish
ln --symbolic ~/dotfiles/.vimrc ~/.vimrc
ln --symbolic ~/dotfiles/config.fish ~/.config/fish/
ln --symbolic ~/dotfiles/aliases.fish ~/.config/fish/aliases.fish

cd ~
