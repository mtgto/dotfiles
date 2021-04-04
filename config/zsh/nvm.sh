# -*- mode: sh; sh-shell: zsh; -*-
if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  source "/usr/local/opt/nvm/nvm.sh"
  if [ -f "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]; then
    source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
  fi
fi
