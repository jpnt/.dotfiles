#
# ~/.kshrc
#

# If not running interactively, don't do anything
case $- in
  *i*)
    eval "$(keychain --eval --quiet --agents ssh github_jpnt bitbucket)"
    ;;
  *) return ;;
esac

set -o vi

# Aliases
alias v='vis'
alias nv='nvim'
alias d='dtach -A'
alias tr='tree | less'
alias ..='cd ..'
alias gb='git branch --all'
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
alias straceps='strace -ftt -e trace=%process,%signal -o "straceps_$(date +%Y%m%d_%H%M%S).log"'
alias stracerw='strace -ftt -e trace=read,write -o "stracerw_$(date +%Y%m%d_%H%M%S).log"'

# Prompt
PS1='$ \u:[\w]> '
