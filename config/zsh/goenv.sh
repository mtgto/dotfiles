# -*- mode: sh; sh-shell: zsh; -*-
if type goenv >/dev/null; then
  if [ -z "$GOENV_ROOT" ]; then
    export GOENV_ROOT="$HOME/.goenv"
  fi
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
fi
