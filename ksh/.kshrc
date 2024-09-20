#
# ~/.kshrc
#

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

set -o vi

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
alias code='code-oss'
alias cc='gcc -Wall -Wextra -fanalyzer'
alias straceps='strace -ftt -o straceps.log -e trace=%process,%signal'
alias stracerw='strace -ftt -o stracerw.log -e trace=read,write'
alias gp='git pull'

# Prompt
#PS1='\u@\h:[\w]\\$ '
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\][\w]\[\e[0m\]\\$ '
