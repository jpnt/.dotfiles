# ~/.profile

export GOPATH="${HOME}/.local/share/go"
export PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"

export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=nvim
export PAGER=less
export LESS='-R --use-color -Dd+r$Du+b$'

# XDG_RUNTIME_DIR fallback
: "${XDG_RUNTIME_DIR:=/run/user/$(id -u)}"
mkdir -p "$XDG_RUNTIME_DIR" && chmod 700 "$XDG_RUNTIME_DIR"

# Source shell-specific interactive config if interactive
if test -n "$PS1"; then
    case "$(ps -p $$ -o comm= 2>/dev/null)" in
        bash) test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc" ;;
    esac
fi

if test "$(tty)" = "/dev/tty1"; then
	export WLR_DRM_DEVICES=/dev/dri/card0
    exec river > /tmp/river-$(date '+%s').log 2>&1
fi
