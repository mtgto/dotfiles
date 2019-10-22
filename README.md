dotfiles

mtgto's dotfiles.

# Requirements

## rcm

First, you install [rcm](https://github.com/thoughtbot/rcm) if you didn't.

```console
brew tap thoughtbot/formulae
brew install rcm
```

Next, clone this repository.

```console
git clone --recursive git@github.com:mtgto/dotfiles.git $HOME/.dotfiles
```

Finally, setup with rcm

```console
RCRC=$HOME/.dotfiles rcup
```

# Installation

## Peco

For enhancd (zshrc).

```console
brew install peco
```

## Powerline

For tmux.

```sh
pip3 install psutil
pip3 install powerline-status
```

## jq

For tmux.

```
brew install jq
```

## reattach-to-user-namespace

For tmux.

```
brew install reattach-to-user-namespace
```

## Description

### tmux

- C-[ C-s
  - save the session
- C-[ C-r
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
