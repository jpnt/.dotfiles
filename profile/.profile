# ~/.profile

export GOPATH="${HOME}/.local/share/go"
export PATH="${HOME}/.local/bin:${GOPATH}/bin:/usr/local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"

export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=nvim
export PAGER=less
export LESS='-R --use-color -Dd+r$Du+b$'

# Source shell-specific interactive config if interactive
if test -n "$PS1"; then
    case "$(ps -p $$ -o comm= 2>/dev/null)" in
        bash) test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc" ;;
    esac
fi

if test "$(tty)" = "/dev/tty1"; then
    export XKB_DEFAULT_LAYOUT="us,pt"
    export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle,caps:swapescape"

    exec river > /tmp/river-$(date '+%s').log 2>&1
fi
