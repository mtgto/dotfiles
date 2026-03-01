# -*- mode: sh; sh-shell: zsh; -*-
function fzf-git-switch() {
  local branch=$(git branch -v --sort=-committerdate | fzf | awk '{print $1}' | sed "s/^\*//")

  if [ -n "$branch" ]; then
    git switch "$branch"
  fi
}

alias gs=fzf-git-switch
