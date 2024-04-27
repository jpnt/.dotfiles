#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Custom shell prompt
PS1='$(slcp $COLUMNS $?)'

# Environment variables
export PATH=$HOME/.local/bin:$PATH
export EDITOR=nvim
export PAGER=nvimpager
export BROWSER=$HOME/.local/bin/floorp
export LESS='-R --use-color -Dd+r$Du+b$'

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

#
# Extras
#

# TODO: Remove this bloated mess, takes ~20ms
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
