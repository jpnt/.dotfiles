#!/bin/sh -
# BTW, shebang is just for clarity.
# ~/.profile - Unified configuration for login shells

# Common environment variables
PATH="${PATH}:${HOME}/.local/bin"
EDITOR=vis
PAGER=less
BROWSER=chromium
LESS='-R --use-color -Dd+r$Du+b$'

export PATH EDITOR PAGER BROWSER LESS

# Create user runtime directory if not exists
if [ -z "${XDG_RUNTIME_DIR}" ]; then
	XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
	mkdir -pm 0700 "${XDG_RUNTIME_DIR}"
	export XDG_RUNTIME_DIR
fi

# Ensure PWD is set
if [ -z "${PWD}" ]; then
	PWD="${HOME}" && export PWD
fi

# Shell-specific configuration
case "${SHELL##*/}" in
	*ksh*)
		[ -f "${HOME}/.kshrc" ] && [ -r "${HOME}/.kshrc" ] && ENV="${HOME}/.kshrc"
		export ENV
	;;
	bash)
		[ -f "${HOME}/.bashrc" ] && [ -r "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
	;;
esac

# Graphical session autostart
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	if [ -z "${WAYLAND_DISPLAY}" ]; then
		exec startw >/dev/null 2>&1
	else
		exec startx >/dev/null 2>&1
	fi
fi
