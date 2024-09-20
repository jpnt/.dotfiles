#
# ~/.bash_profile
#

export PATH=$HOME/.local/bin:$PATH
export EDITOR=nvim
export PAGER=nvimpager
export BROWSER=$HOME/.local/bin/floorp
export LESS='-R --use-color -Dd+r$Du+b$'

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx;
fi
