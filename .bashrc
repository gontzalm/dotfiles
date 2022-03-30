#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set neovim as default editor
export EDITOR="nvim"

# Set nvim as manpager
export MANPAGER="nvim +Man!"
export MANWIDTH="999"

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Prompt
PS1="\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] "

# Aliases
alias ls="exa -al --color=always --group-directories-first"
alias cp="cp -i"
alias df="df -h"
alias free="free -h"
alias vim="nvim"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias tsm="transmission-remote"
alias tsm-clear="tsm -l | grep 100% | awk '{print $1}'| paste -d, -s | xargs -i transmission-remote -t {} -r"
alias rspotifyd="systemctl --user restart spotifyd"
alias bt="sudo bluetoothctl"
alias shutdown="sudo shutdown now"
alias reboot="sudo shutdown -r now"
alias extend="xlayoutdisplay && nitrogen --restore"

tsm-status () {
  while true; do
    cat << EOF
Transmission CLI Status:

$(tsm -l)

Press Ctrl-C to exit
EOF
    sleep 0.5
    clear
  done
}

zathura ()
{
  /usr/bin/zathura "$1" --fork && exit
}

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# neofetch if not in laptop
if [ "$HOSTNAME" != "miair13" ] ; then
    neofetch
fi

# add ~/bin to PATH
export PATH=~/bin:"$PATH"
