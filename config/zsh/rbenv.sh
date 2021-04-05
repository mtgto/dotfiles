# -*- mode: sh; sh-shell: zsh; -*-
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  function load_rbenv() {
    eval "$(rbenv init - zsh)"
  }
  async_start_worker rbenv_worker -n
  async_register_callback rbenv_worker load_rbenv
  async_job rbenv_worker sleep 0.1
fi
