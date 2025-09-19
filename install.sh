#!/bin/sh

[ $# -eq 1 ] || { echo "usage: $0 <dir>"; exit 1; }
[ -d "$1" ] || { echo "error: $1 not found or is not a directory"; exit 1; }

src="${1%/}" # strip trailing slash

find "$src" -type f -printf '%P\n' | while read -r rel_path; do
    target_path="$HOME/$rel_path"

    mkdir -p "$(dirname "$target_path")"
    [ -e "$target_path" ] && rm -f "$target_path"
    ln -sf "$PWD/$src/$rel_path" "$target_path" \
        && echo "Linked $target_path -> $PWD/$src/$rel_path"
done
