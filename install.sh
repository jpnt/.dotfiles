#!/bin/sh

[ $# -eq 1 ] || { echo "usage: $0 <dir>"; exit 1; }
[ -d "$1" ] || { echo "error: $1 not found or is not a directory"; exit 1; }

# Find all files in the specified directory and create symlinks
find "$1" -type f | while read -r file; do
    # Remove the directory prefix (e.g., "bash/.bashrc" becomes ".bashrc")
    target_path="$HOME/${file#$1/}"
    
    # Create parent directories if they don't exist
    mkdir -p "$(dirname "$target_path")"
    
    # Create symlink (remove existing file/link first)
    [ -e "$target_path" ] && rm -f "$target_path"
    ln -sf "$PWD/$file" "$target_path"
    
    echo "Linked $target_path -> $PWD/$file"
done

