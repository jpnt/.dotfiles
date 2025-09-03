# ~/.profile

export GOPATH="${HOME}/.local/share/go"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"
export PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"

# Basic environment configuration
export \
    XDG_CONFIG_HOME="${HOME}/.config" \
    TERMINAL=footclient \
    EDITOR=nvim \
    PAGER=less \
    BROWSER=firefox \
    GTK_THEME=Adwaita:dark \
    QT_STYLE_OVERRIDE=Adwaita-Dark \
    LESS='-R --use-color -Dd+r$Du+b$'

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

# Source shell-specific interactive config if we're interactive
if test -n "$PS1"; then
    case "$(ps -p $$ -o comm= 2>/dev/null)" in
        bash) test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc" ;;
    esac
fi

# Start graphical session on tty1 if not already running
if test "$(tty)" = "/dev/tty1" && test -z "$WAYLAND_DISPLAY"; then
    exec river 2>&1 | tee -a ~/.local/state/river.log
    # exec sh -c 'slstatus -s | dwl 2>&1 | tee -a ~/.local/state/dwl.log'
fi
