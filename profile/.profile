# ~/.profile

# Basic environment configuration
export \
    XDG_CONFIG_HOME="${HOME}/.config" \
    XDG_RUNTIME_DIR="/run/user/$(id -u)" \
    TERMINAL=footclient \
    EDITOR=nvim \
    PAGER=less \
    BROWSER=firefox \
    GTK_THEME=Adwaita:dark \
    QT_STYLE_OVERRIDE=Adwaita-Dark \
    GOPATH="${HOME}/.local/share/go" \
    LESS='-R --use-color -Dd+r$Du+b$' \
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
[ ! -d "$XDG_RUNTIME_DIR" ] && mkdir -pm 0700 "$XDG_RUNTIME_DIR"
