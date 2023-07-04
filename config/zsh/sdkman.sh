# -*- mode: sh; sh-shell: zsh; -*-
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  function load_sdkman() {
    export SDKMAN_DIR="$HOME/.sdkman"
    source "$HOME/.sdkman/bin/sdkman-init.sh"
  }
  async_start_worker sdkman_worker -n
  async_register_callback sdkman_worker load_sdkman
  async_job sdkman_worker sleep 0.1
fi
