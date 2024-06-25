# ~/.kshrc

set -o vi

# Custom shell prompt
PS1='$(slcp $COLUMNS $?)'

# Aliases
alias ls='ls --color=always'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=always'
alias tree='tree -C'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias ..='cd ..'
alias nv='nvim'
alias code='code-oss'
alias docker='podman'
alias cc='gcc -Wall -Wextra -fanalyzer'
alias straceps='strace -ftt -o straceps.log -e trace=%process,%signal'
alias stracerw='strace -ftt -o stracerw.log -e trace=read,write'
alias gp='git pull'
alias i='cd'
