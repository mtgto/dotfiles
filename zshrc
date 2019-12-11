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
typeset -gU PATH

if type brew >/dev/null; then
  export HOMEBREW_PREFIX=$(brew --prefix)
fi

# Env
export LANG=ja_JP.UTF-8
export LC_CTYPE=$LANG

# Jenv 遅いので遅延ロード
# https://github.com/shihyuho/zsh-jenv-lazy/blob/master/jenv-lazy.plugin.zsh
export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
if type jenv >/dev/null; then
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

# Homebrew completions
if [ -d ${HOMEBREW_PREFIX}/share/zsh/site-functions ]; then
	fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fi

if [ -d "${HOMEBREW_PREFIX}/opt/gettext/bin" ]; then
	export PATH=${HOMEBREW_PREFIX}/opt/gettext/bin:$PATH
fi

# Ruby
if [ -d "${HOMEBREW_PREFIX}/opt/ruby/bin" ]; then
	export PATH=${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH
	export PATH=`gem environment gemdir`/bin:$PATH
fi

# Rubygems
if type ruby >/dev/null && type gem >/dev/null; then
  export PATH="$(ruby -r rubygems -e 'print Gem.user_dir')/bin:$PATH"
fi

# Rbenv
if [ -e "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init - zsh)"
fi

# Bundler
if [ -z $BUNDLE_JOBS ]; then
  export BUNDLE_JOBS=4
fi

# less
export LESS="-iMR"

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
alias bi="bundle install"
alias be="bundle exec"

if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

if [ -d "${HOME}/work/chromium/depot_tools" ]; then
  export PATH="${HOME}/work/chromium/depot_tools":$PATH
fi

if [ -d "${HOME}/graalvm-ce-1.0.0-rc13" ]; then
    export GRAALVM_HOME="${HOME}/graalvm-ce-1.0.0-rc13/Contents/Home"
#    export PATH=${GRAALVM_HOME}/bin:$PATH
fi

# ZPlugin
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice as'completion'
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait"!0" lucid blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice wait"!1" lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# プロファイル
# if (which zprof > /dev/null 2>&1) ;then
#  zprof | less
# fi
