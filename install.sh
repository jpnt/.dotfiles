#!/bin/sh
[ $# -eq 0 ] && echo "usage: $0 <config>" && exit 1
[ ! -d "$1" ] && echo "error: $1 not found" && exit 1
find "$1" -type f -exec sh -c 'mkdir -p "$HOME/$(dirname "${1#*/}")"; ln -sf "$PWD/$1" "$HOME/${1#*/}"; echo "$HOME/${1#*/}"' _ {} \;
