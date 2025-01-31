#!/bin/sh -
# BTW, shebang is just for clarity.
# ~/.profile - Unified configuration for login shells

# Environment variables
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

# Shell-specific configuration, extract only shell name
case "${SHELL##*/}" in
	*ksh)
		[ -f "${HOME}/.kshrc" ] && [ -r "${HOME}/.kshrc" ] && ENV="${HOME}/.kshrc"
		export ENV
	;;
	bash)
		[ -f "${HOME}/.bashrc" ] && [ -r "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
	;;
esac


# Graphical session autostart
SESSION_TYPE="x11"
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	case "${SESSION_TYPE}" in
		x11)
			exec startx
		;;
		wayland)
			[ -n "${WAYLAND_DISPLAY}" ] || exec startw
		;;
		*)
			echo "Invalid SESSION_TYPE: ${SESSION_TYPE}" >&2
		;;
	esac
fi
