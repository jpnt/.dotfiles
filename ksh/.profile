#
# ~/.profile
#

PATH=$PATH:$HOME/.local/bin
EDITOR=vim
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

# TODO: add validation if using ksh or not
# TODO: make .profile universal (at least for bash/ksh) so no need for .bash_profile
if [ -f $HOME/.kshrc -a -r $HOME/.kshrc ]; then
	ENV=$HOME/.kshrc
	export ENV
fi

# TODO: add validation if using Xorg (not using Wayland)
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx;
fi
