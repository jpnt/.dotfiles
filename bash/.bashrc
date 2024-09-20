#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias code='code-oss'
alias cc='gcc -Wall -Wextra -fanalyzer'
alias straceps='strace -ftt -o straceps.log -e trace=%process,%signal'
alias stracerw='strace -ftt -o stracerw.log -e trace=read,write'
alias gp='git pull'

# Prompt
PS1='$ \u:[\w]> '

#
# Extras
#

eval "$(jump shell)"

sdkman_init() {
	export SDKMAN_DIR="$HOME/.sdkman"
	[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

dotnet_init() {
	export DOTNET_CLI_TELEMETRY_OPTOUT=1
	export DOTNET_ROOT=/usr/lib/dotnet/dotnet8
	export PATH="$PATH:$DOTNET_ROOT:$HOME/.dotnet/tools"
}
