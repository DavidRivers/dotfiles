status --is-interactive; and . ~/.config/fish/aliases.fish

set fish_key_bindings fish_vi_key_bindings

if test -e ~/dotfiles/git-custom-commands
  set --export PATH ~/dotfiles/git-custom-commands $PATH
end
