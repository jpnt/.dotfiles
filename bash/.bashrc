#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -AlX'
alias tree='tree -C'

PS1="\[\e[32m\][\w] $ \[\e[00m\]"

# root PS1:
# PS1="\[\e[31m\][\w] # \[\e[00m\]"
