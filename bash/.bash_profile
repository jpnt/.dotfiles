#
# ~/.bash_profile
#

export PATH=$HOME/.local/bin:$PATH
export EDITOR=hx
export PAGER=less
export BROWSER=chromium
export LESS='-R --use-color -Dd+r$Du+b$'

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx;
fi
