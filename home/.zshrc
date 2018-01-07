# -*- mode: sh; sh-shell: zsh; -*-
HISTFILE=$HOME/.zhistory
# メモリ上に保存される件数（検索できる件数）
HISTSIZE=4096
# ファイルに保存される件数
SAVEHIST=4096
setopt extended_history
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# 第三者の書き込み制限を外す
umask 002

# 重複パスを登録しない
typeset -U path

# See https://carlosbecker.com/posts/speeding-up-zsh/
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# ZPlug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

zplug "zsh-users/zsh-syntax-highlighting", from:github

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

#zplug load --verbose
zplug load

# Homeshick
export HOMESHICK_DIR=/usr/local/opt/homeshick
source $HOMESHICK_DIR/homeshick.sh

# エイリアス設定
alias g=git
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias gst="git status"
alias gp="git push"
alias gr="git remote"
