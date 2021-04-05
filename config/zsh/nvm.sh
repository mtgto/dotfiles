# -*- mode: sh; sh-shell: zsh; -*-
if [ -f "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]; then
  function load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
    if [ -f "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]; then
      source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
    fi
  }
  async_start_worker nvm_worker -n
  async_register_callback nvm_worker load_nvm
  async_job nvm_worker sleep 0.1
fi
