#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim 'set ft=man ts=8 nomod nolist noma' -\""

# Set vi mode
set -o vi
bind -m vi-command "Control-l: clear-screen"
bind -m vi-insert "Control-l: clear-screen"

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Prompt
PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '

# Aliases
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias cp="cp -i"
alias df="df -h"
alias free="free -h"
alias more="less"
alias vim="nvim"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gontz/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gontz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gontz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gontz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
