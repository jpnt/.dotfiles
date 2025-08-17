# ~/.profile

# Basic environment configuration
export \
    XDG_CONFIG_HOME="${HOME}/.config" \
    TERMINAL=footclient \
    EDITOR=nvim \
    PAGER=less \
    BROWSER=firefox \
    GTK_THEME=Adwaita:dark \
    QT_STYLE_OVERRIDE=Adwaita-Dark \
    LESS='-R --use-color -Dd+r$Du+b$' \
    GOPATH="${HOME}/.local/share/go" \
    MANPATH="${HOME}/.local/share/man:${MANPATH}" \
    PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"

# Wayland‐specific settings
export \
    XDG_SESSION_TYPE=wayland \
    GDK_BACKEND=wayland \
    QT_QPA_PLATFORM=wayland-egl \
    MOZ_ENABLE_WAYLAND=1 \
    CLUTTER_BACKEND=wayland \
    SDL_VIDEODRIVER=wayland \
    ELM_DISPLAY=wl \
    _JAVA_AWT_WM_NONREPARENTING=1

# Create runtime dir if does not exist already
if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR="/tmp/${UID}-runtime-dir"
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir -p "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

# Source shell-specific interactive config if we're interactive
if test -n "$PS1"; then
    case "$(ps -p $$ -o comm= 2>/dev/null)" in
        bash) [ -r "${HOME}/.bashrc" ] && . "${HOME}/.bashrc" ;;
	# TODO: add yash
    esac
fi
