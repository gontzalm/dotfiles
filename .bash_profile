#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval "$(gh completion -s bash)"

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
