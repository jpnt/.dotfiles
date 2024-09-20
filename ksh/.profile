#
# ~/.profile
#

PATH=$PATH:$HOME/.local/bin
EDITOR=nvim
PAGER=less
BROWSER=chromium
LESS='-R --use-color -Dd+r$Du+b$'

export PATH EDITOR PAGER BROWSER LESS

if [ -z "$XDG_RUNTIME_DIR" ]; then
	XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
	mkdir -pm 0700 "$XDG_RUNTIME_DIR"
	export XDG_RUNTIME_DIR
fi

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
