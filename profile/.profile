# ~/.profile

export GOPATH="${HOME}/.local/share/go"
export PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"

export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=nvim
export PAGER=less

# --- this should be the end of .profile

# TODO: this is all GUI stuff.
export TERMINAL=footclient \
    GTK_THEME=Adwaita:dark \
    QT_STYLE_OVERRIDE=Adwaita-Dark \
    LESS='-R --use-color -Dd+r$Du+b$'

# TODO: Environment is over-specified for Wayland
# In s6-rc world, these belong to a session service envdir, not a login file.
# Wayland‐specific settings
export \
    WLR_DRM_DEVICES=/dev/dri/card0 \
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
# TODO: This assumes:
# tty1 always maps to graphical session
# no other login path exists
# no restart scenarios
# no parallel sessions
if test "$(tty)" = "/dev/tty1" && test -z "$WAYLAND_DISPLAY"; then
    # TODO: problems:
        # implicit session ownership
	# no supervision
	# no restart policy
	# no dependency ordering
	# tty-based branching logic
    exec river > ~/.local/state/river.log 2>&1
fi


# tldr: .profile should answer only:
# what environment exists for this user session
# not: what graphical session runs
# what compositor starts
# which tty becomes graphical
