# ~/.profile – unified login‐shell config

# Session type (default to wayland if not set)
: "${SESSION_TYPE:=wayland}"

# Environment variables
export \
  GOPATH="${HOME}/.local/share/go" \
  XDG_CONFIG_HOME="${HOME}/.config" \
  XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/$(id -u)-runtime-dir}" \
  TERMINAL=footclient \
  EDITOR=nvim \
  PAGER=less \
  BROWSER=firefox \
  GTK_THEME=Adwaita:dark \
  QT_STYLE_OVERRIDE=Adwaita-Dark \
  _JAVA_AWT_WM_NONREPARENTING=1

# Ensure XDG_RUNTIME_DIR exists with secure perms
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
  mkdir -pm 0700 "$XDG_RUNTIME_DIR"
fi

# PATH
export PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"

# LESS options (color + nicer scrolling)
export LESS='-R --use-color -Dd+r$Du+b$'

# Wayland‐specific settings
if [ "$SESSION_TYPE" = "wayland" ]; then
  export \
    XKB_DEFAULT_LAYOUT=pt \
    XDG_SESSION_TYPE=wayland \
    XDG_CURRENT_DESKTOP=sway \
    GDK_BACKEND=wayland \
    QT_QPA_PLATFORM=wayland-egl \
    MOZ_ENABLE_WAYLAND=1 \
    CLUTTER_BACKEND=wayland \
    SDL_VIDEODRIVER=wayland
fi

# Ensure PWD is set (rarely needed)
: "${PWD:=$HOME}"
export PWD

# Shell‐specific setup
case "${SHELL##*/}" in
  ksh)
    ENV="${HOME}/.kshrc"
    [ -r "$ENV" ] && export ENV
    ;;
  bash)
    [ -r "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
    ;;
esac

# Graphical login from tty1
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
  case "$SESSION_TYPE" in
    x11)    exec startx ;;
    wayland) exec sh -c 'slstatus -s | dwl -s dwlchild' ;;
    *)      echo "Invalid SESSION_TYPE: $SESSION_TYPE" >&2 ;;
  esac
fi
