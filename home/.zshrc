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
# C-sなどが機能するようにフロー制御を無効化
setopt noflowcontrol
bindkey -e

# 第三者の書き込み制限を外す
umask 002

# 重複パスを登録しない
typeset -U path

# Env
export LANG=ja_JP.UTF-8
export LC_CTYPE=$LANG
export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:$PATH
export PATH=/usr/local/opt/gettext/bin:$PATH

# Homeshick
export HOMESHICK_DIR=/usr/local/opt/homeshick
source $HOMESHICK_DIR/homeshick.sh

# Jenv 遅いので遅延ロード
# https://github.com/shihyuho/zsh-jenv-lazy/blob/master/jenv-lazy.plugin.zsh
export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
if type jenv > /dev/null; then
    export PATH="${JENV_ROOT}/bin:${JENV_ROOT}/shims:${PATH}"
    function jenv() {
        unset -f jenv
        eval "$(command jenv init -)"
        jenv $@
    }
fi

# Golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# エイリアス設定
alias reload='exec zsh -l'
alias g=git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glg="git log"
alias gst="git status"
alias gp="git push"
alias gr="git remote"
alias m="make"
alias k="kubectl"

if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

# ZPlugin
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin

zplugin light "mafredri/zsh-async"
zplugin light "sindresorhus/pure"
zplugin light "zsh-users/zsh-syntax-highlighting"
zplugin light "zsh-users/zsh-completions"

zplugin ice wait"!0" atinit"zpcompinit; zpcdreplay"

# プロファイル
#if (which zprof > /dev/null 2>&1) ;then
#  zprof
#fi
