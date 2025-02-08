#!/bin/sh -
# BTW, shebang is just for clarity.
# ~/.profile - Unified configuration for login shells

SESSION_TYPE="wayland"

# Environment variables
export GOPATH="${HOME}/.local/go"
export PATH="${PATH}:${GOPATH}/bin:${HOME}/.local/bin"
export LESS='-R --use-color -Dd+r$Du+b$'
export EDITOR=vis
export PAGER=less
export BROWSER=firefox
export _JAVA_AWT_WM_NONREPARENTING=1

if [ "${SESSION_TYPE}" = "wayland" ]; then
	export XKB_DEFAULT_LAYOUT=pt
	export XDG_SESSION_TYPE=wayland
	export GDK_BACKEND=wayland
	export QT_QPA_PLATFORM=wayland-egl
	export MOZ_ENABLE_WAYLAND=1
fi

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
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	case "${SESSION_TYPE}" in
		x11)
			exec startx
			# exec sx
			;;
		wayland)
			exec dwl -s 'dwlchild'
			;;
		*)
			echo "Invalid SESSION_TYPE: ${SESSION_TYPE}" >&2
			;;
	esac
fi
