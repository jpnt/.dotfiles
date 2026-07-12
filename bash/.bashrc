#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='$ \u:[\w]> '

# Vim mode
set -o vi

# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias ..='cd ..'
alias l='eza -alh --color-scale --icons --group --group-directories-first'
alias t='l -T'
alias ta='tmux attach'
alias nv='nvim'
alias open='xdg-open'
alias g='git status -sb'
alias gb='git branch --all'
alias gl='git log --oneline --graph --decorate'
alias gp='git pull --rebase'
alias gm='git submodule update --init --recursive'
alias gd='git diff --color-moved --patience'
alias straceps='strace -ftt -e trace=%process,%signal -o "straceps_$(date +%Y%m%d_%H%M%S).log"'
alias stracerw='strace -ftt -e trace=read,write -o "stracerw_$(date +%Y%m%d_%H%M%S).log"'
alias rsyncpreserve='rsync -avHAXS --numeric-ids'
alias k='kubecolor'
alias docker='podman'

# Functions
hex() { [ $# -gt 0 ] && printf '0x%x\n' "$@" || while read -r n; do printf '0x%x\n' "$n"; done; }
dec() { [ $# -gt 0 ] && printf '%d\n' "$@" || while read -r n; do printf '%d\n' "$n"; done; }
oct() { [ $# -gt 0 ] && printf '0%o\n' "$@" || while read -r n; do printf '0%o\n' "$n"; done; }

sel() { local dir="${1:-.}"; fd . "$dir" -0 | fzf -m --read0 --print0; }
run() { xargs -0 -r "$@"; }

