dotfiles

mtgto's dotfiles.

# Requirements

## rcm

First, you install [rcm](https://github.com/thoughtbot/rcm) if you didn't.

```bash
brew tap thoughtbot/formulae
brew install rcm
```

Ahd then, clone this castle.

```
homeshick clone mtgto/dotfiles
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
