set -u aliases ~/.config/fish/aliases.fish

function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function acs
  apt-cache search $argv
end

function agi
  sudo apt-get install $argv
end

function firefox \
  open -a Firefox
end

function ea \
	--description "edit and reload aliases"
	vim $aliases
	and . $aliases
end

function a \
	--description "directory listing"
	ls -Ga $argv
end

function c \
  --description "clear"
  clear
end

function tdp \
	--description "tmuxinator distil-portal"
  /usr/local/bin/fish --command "tmux -2 -l -c 'tmuxinator start distil-portal'"
end

function tpm \
	--description "tmuxinator pickymug"
  /usr/local/bin/fish --command "tmux -2 -l -c 'tmuxinator start pickymug'"
end

complete --command v --condition '[ (pwd) != "$HOME" ]' --authoritative --argument '(ag --depth 7 --max-count 250 -g \'.*\' ^/dev/null)'

function v \
  --description "automcompleted vim"
  vim $argv
end

for dir in (ls ~/Dev/)
  set dir (echo $dir | sed 's#/$##')
  eval "function $dir; cd ~/Dev/$dir; end"
end
