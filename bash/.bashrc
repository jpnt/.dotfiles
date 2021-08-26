#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

alias tree='tree -C'

alias ..='cd ..'

alias untar='tar -xvzf'

PS1="\[\e[32m\][\w] $ \[\e[00m\]"

# root PS1:
# PS1="\[\e[31m\][\w] # \[\e[00m\]"
