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
#PS1='$(slcp $COLUMNS $?)'
PS1='\[[1;32;40m\]\h\[[0;37;40m\]:\[[34;40m\][\[[1;31;40m\]\u\[[0;34;40m\]]\[[0;37;40m\]:\[[35;40m\]\w\[[1;33;40m\]#\[[0m\] '
