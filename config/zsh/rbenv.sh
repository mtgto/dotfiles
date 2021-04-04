# -*- mode: sh; sh-shell: zsh; -*-
if [ -e "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init - zsh)"
fi
