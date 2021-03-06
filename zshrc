# -*- mode: sh; sh-shell: zsh; -*-
export DOTFILES=$HOME/.dotfiles
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
umask 022

# 重複パスを登録しない
typeset -gU PATH

if type brew >/dev/null; then
  : ${HOMEBREW_PREFIX:=$(brew --prefix)}
  # https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1
fi

# Env
export LANG=ja_JP.UTF-8
export LC_CTYPE=$LANG
export DOTNET_CLI_TELEMETRY_OPTOUT=1

if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin":"$PATH"
fi

# Golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin":"$PATH"

# Homebrew completions
if [ -d ${HOMEBREW_PREFIX}/share/zsh/site-functions ]; then
	fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fi

if [ -d "${HOMEBREW_PREFIX}/opt/gettext/bin" ]; then
	export PATH=${HOMEBREW_PREFIX}/opt/gettext/bin:$PATH
fi

# Ruby
if [ -d "${HOMEBREW_PREFIX}/opt/ruby/bin" ]; then
	export PATH=${HOMEBREW_PREFIX}/opt/ruby/bin:"$PATH"
  # TODO: it is too slow
	# export PATH=`gem environment gemdir`/bin:"$PATH"
fi

# Bundler
if [ -z $BUNDLE_JOBS ]; then
  export BUNDLE_JOBS=4
fi

# less
export LESS="-iMR"

# next.js
# https://nextjs.org/telemetry#how-do-i-opt-out
export NEXT_TELEMETRY_DISABLED=1

# git
checkout-pull-request () {
  git fetch origin pull/${1}/head:pr/${1} && git checkout pr/${1}
}

# エイリアス設定
alias reload='exec zsh -l'
alias g=git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
gcd() {
  git checkout $(basename $(git symbolic-ref --quiet refs/remotes/origin/HEAD))
}
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
alias dotfiles="cd ${DOTFILES}"
alias reset-window-name="tmux setw automatic-rename"

if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi
if type nvim >/dev/null; then
  alias v=nvim
  alias vi=nvim
  alias vim=nvim
  export EDITOR=nvim
fi

if [ -d "${HOME}/work/chromium/depot_tools" ]; then
  export PATH="${HOME}/work/chromium/depot_tools":"$PATH"
fi

if [ -d "${HOME}/graalvm-ce-1.0.0-rc13" ]; then
    export GRAALVM_HOME="${HOME}/graalvm-ce-1.0.0-rc13/Contents/Home"
#    export PATH=${GRAALVM_HOME}/bin:$PATH
fi

# zinit
source "${DOTFILES}/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light mafredri/zsh-async
zinit light sindresorhus/pure

zinit ice as'completion'
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit light zsh-users/zsh-autosuggestions

zinit ice wait"!0" lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait"!1" lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

source $DOTFILES/config/zsh/nvm.sh
source $DOTFILES/config/zsh/rbenv.sh
source $DOTFILES/config/zsh/goenv.sh
source $DOTFILES/config/zsh/jenv.sh

# fzf
if [[ -d "${HOMEBREW_PREFIX}/opt/fzf/bin" ]]; then
  export PATH="${HOMEBREW_PREFIX}/opt/fzf/bin":$PATH
  [[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# 末尾に置くこと
# プロファイルを取るときは ~/.zshenv に "zmodload zsh/zprof && zprof" を書く
if (type zprof >/dev/null) ;then
 zprof | less
fi
