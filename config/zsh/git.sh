# -*- mode: sh; sh-shell: zsh; -*-
function fzf-git-switch() {
  local branch=$(git branch -v --sort=-committerdate | fzf | awk '{print $1}' | sed "s/^\*//")

  if [ -n "$branch" ]; then
    git switch "$branch"
  fi
}

function commit-with-claude() {
  # /plugin install commit-commands@claude-plugins-official
  printf "Running claude...\n" >&2
  claude --no-session-persistence --strict-mcp-config --model haiku \
    --print "/commit-commands:commit $*"
}

function git-squash() {
  if [ -z "$1" ]; then
    echo "Usage: git-squash <from>" >&2
    return 1
  fi
  git reset --soft "$1" && git commit
}

alias gs=fzf-git-switch
alias gci=commit-with-claude
alias gsq=git-squash
