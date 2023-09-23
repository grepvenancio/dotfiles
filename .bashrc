# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# some ls aliases
alias vim="nvim"
alias ls='exa --icons -hl --no-user --git --git-ignore'
alias la='exa --icons -hla --no-user --git'
alias lt='exa --icons -hlT --no-user --git --git-ignore'
alias icat='kitty icat'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Add rust to path
. $HOME/.cargo/env

# Add rtx to path
eval "$($HOME/.cargo/bin/rtx activate bash)"

# Init starship
eval "$(starship init bash)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
