#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Enable bash-completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


# Environment variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export PAGER=nvimpager
export BROWSER=vivaldi-stable
# Support for color in less
export LESS='-R --use-color -Dd+r$Du+b$'
# Custom shell prompt
export PS1="\[$(tput setaf 2)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\w\[$(tput sgr0)\] $ "


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


# Transparency for suckless terminal
term=$(cat /proc/$PPID/comm)
if [[ $term == "st" ]]; then
	transset "0.8" --id $WINDOWID >/dev/null
fi

#
# Extras
#

#. "$HOME/.cargo/env"
#
#eval "$(zoxide init bash)"
#
##THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
