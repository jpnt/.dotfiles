#
# ~/.profile
#

PATH=$PATH:$HOME/.local/bin
EDITOR=nvim
PAGER=less
BROWSER=$HOME/.local/bin/floorp
LESS='-R --use-color -Dd+r$Du+b$'

export PATH EDITOR PAGER BROWSER LESS

if [ -z "$PWD" ]; then
	PWD=$HOME
	export PWD
fi

if [ -f $HOME/.kshrc -a -r $HOME/.kshrc ]; then
	ENV=$HOME/.kshrc
	export ENV
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
	exec startx;
fi
