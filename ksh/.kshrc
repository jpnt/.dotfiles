#
# ~/.kshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

eval "$(keychain --eval --quiet --agents ssh github_jpnt bitbucket)"

# Aliases
alias v='vis'
alias nv='nvim'
alias a='abduco'
alias tr='tree | less'
alias ..='cd ..'
alias gb='git branch --all'
alias gl='git log --oneline --graph --decorate'
alias ls='ls --color=always'
alias l='eza -alh --icons --group --group-directories-first --color-scale'
alias grep='grep --color=always'
alias tree='tree -C'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias straceps='strace -ftt -e trace=%process,%signal -o "straceps_$(date +%Y%m%d_%H%M%S).log"'
alias stracerw='strace -ftt -e trace=read,write -o "stracerw_$(date +%Y%m%d_%H%M%S).log"'

# Prompt
PS1='$ \u:[\w]> '
