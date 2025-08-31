#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

eval "$(keychain --eval --quiet github_jpnt bitbucket)"

# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias tree='tree -C'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias ..='cd ..'
alias ta='tmux attach'
alias tn='tmux new -s'
alias nv='nvim'
alias llm='uvx ramalama'
alias g='git status -sb'
alias gb='git branch --all'
alias gl='git log --oneline --graph --decorate'
alias gp='git pull --rebase=interactive'
alias gm='git submodule update --init --recursive'
alias gd='git diff --color-moved --patience'
alias l='eza -alh --icons --group --group-directories-first --color-scale'
alias straceps='strace -ftt -e trace=%process,%signal -o "straceps_$(date +%Y%m%d_%H%M%S).log"'
alias stracerw='strace -ftt -e trace=read,write -o "stracerw_$(date +%Y%m%d_%H%M%S).log"'

# Prompt
PS1='$ \u:[\w]> '
