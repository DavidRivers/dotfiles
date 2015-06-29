set -u aliases ~/.config/fish/aliases.fish

function a \
	--description "Directory listing"
	if count $argv > 0
		ls -Ga $argv[1]
	else
		ls -Ga
	end
end

function ea \
	--description "Edit Aliases (and then reload them)"
	vim $aliases
	and . $aliases
end
