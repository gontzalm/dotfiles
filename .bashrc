#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# env variables
export EDITOR="nvim"
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"

# ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# prompt
PS1="\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] "

# aliases
alias activate=".venv/bin/activate"
alias bt="sudo bluetoothctl"
alias cat="bat"
alias config="/usr/bin/git --git-dir=\${HOME}/.dotfiles --work-tree=\${HOME}"
alias cp="cp -i"
alias df="df -h"
alias free="free -h"
alias ls="eza -al --color=always --group-directories-first"
alias man="batman"
alias reboot="sudo shutdown -r now"
alias rg="batgrep"
alias shutdown="sudo shutdown now"
alias vim="nvim"
zathura() {
  /usr/bin/zathura "$1" --fork
}

# add ~/bin and ~/.cargo/bin to PATH
export PATH=~/bin:~/.cargo/bin:"$PATH"

# starship
eval "$(starship init bash)"
