#!/bin/sh
set -eu

usage() {
    echo "usage: $0 [-n] [-f] <dir> [dir ...]" >&2
    exit 1
}

DRYRUN=0
FORCE=0

while getopts "nf" opt; do
    case "$opt" in
        n) DRYRUN=1 ;;
        f) FORCE=1 ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

[ $# -ge 1 ] || usage

ignore_top() {
    case "$1" in
        _*|install.sh|flatpak-theme.sh|README.md) return 0 ;;
        *) return 1 ;;
    esac
}

link_file() {
    src=$1
    dst=$2

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        [ "$FORCE" -eq 1 ] || {
            echo "skip (exists): $dst" >&2
            return
        }
    fi

    [ "$DRYRUN" -eq 1 ] && {
        echo "ln -sf $src $dst"
        return
    }

    mkdir -p "$(dirname "$dst")"
    rm -f "$dst"
    ln -s "$src" "$dst"
    echo "linked $dst"
}

for mod in "$@"; do
    [ -d "$mod" ] || {
        echo "error: $mod not a directory" >&2
        exit 1
    }

    ignore_top "$mod" && continue

    (cd "$mod" && find . -type f | sed 's|^\./||') |
    while read -r rel; do
        link_file "$PWD/$mod/$rel" "$HOME/$rel"
    done
done

