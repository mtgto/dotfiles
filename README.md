dotfiles
====
mtgto's dotfiles.

# Requirements

## rcm

First, you install [rcm](https://github.com/thoughtbot/rcm) if you didn't.

```console
brew install rcm
```

Next, clone this repository.

```console
git clone --recursive git@github.com:mtgto/dotfiles.git $HOME/.dotfiles
```

Finally, setup with rcm

```console
# install
RCRC=$HOME/.dotfiles/rcrc rcup

# update
rcup
```

# Installation

## fzf

For enhanced zsh, nvim.

```console
brew install fzf
```

## Powerline

For tmux.

```console
pip3 install psutil
pip3 install powerline-status
```

## jq

For tmux.

```console
brew install jq
```

## rg

```console
brew install rg
```

## reattach-to-user-namespace

For tmux.

```
brew install reattach-to-user-namespace
```

## Description

### tmux

Prefix is `C-t`

- C-t C-s
  - save the session
- C-t C-r
  - resurrect the saved session

# Configuration

## git config

Write `~/.gitconfig.local`.
ex:

```
[user]
	name = mtgto
	email = hogerappa@gmail.com
```

# License

MIT
