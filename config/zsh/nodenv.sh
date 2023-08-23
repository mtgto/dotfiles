# -*- mode: sh; sh-shell: zsh; -*-
if type nodenv >/dev/null; then
  function load_nodenv() {
    eval "$(nodenv init -)"
  }
  async_start_worker nodenv_worker -n
  async_register_callback nodenv_worker load_nodenv
  async_job nodenv_worker sleep 0.1
fi
