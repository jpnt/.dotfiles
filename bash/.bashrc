#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*)
        eval "$(keychain --eval --quiet --agents ssh github_jpnt bitbucket)"
        ;;
    *) return ;;
esac

set -o vi

# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Aliases
alias v='vis'
alias nv='nvim'
alias tr='tree | less'
alias d='dtach -A'
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
