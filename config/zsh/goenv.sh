# -*- mode: sh; sh-shell: zsh; -*-
if type goenv >/dev/null; then
  if [ -z "$GOENV_ROOT" ]; then
    export GOENV_ROOT="$HOME/.goenv"
  fi
  export PATH="$GOENV_ROOT/bin:$PATH"
  function load_goenv() {
    eval "$(goenv init -)"
  }
  async_start_worker goenv_worker -n
  async_register_callback goenv_worker load_goenv
  async_job goenv_worker sleep 0.1
fi
