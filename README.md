dotfiles

mtgto's dotfiles.

# Requirements

## Homeshick

First, you install [homeshick](https://github.com/andsens/homeshick) if you didn't.

```bash
brew install homeshick
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
