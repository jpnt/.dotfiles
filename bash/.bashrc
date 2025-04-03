#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

set -o vi

# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Aliases
alias ls='ls --color=always'
alias l='ls -CF'
alias ll='ls -lF'
alias la='ls -A'
alias lla='ls -alF'
alias grep='grep --color=always'
alias tree='tree -C'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias ..='cd ..'
alias nv='nvim'
alias straceps='strace -ftt -o straceps.log -e trace=%process,%signal'
alias stracerw='strace -ftt -o stracerw.log -e trace=read,write'
alias gb='git branch --all'

# Prompt
PS1='$ \u:[\w]> '
