#!/usr/bin/env sh
set -eu

FONT="0xProto"
VERSION="v3.4.0"
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$VERSION/$FONT.tar.xz"
FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cd "$tmp"

curl -fL --progress-bar -O "$URL"
tar -xf "$FONT.tar.xz"

mkdir -p "$FONT_DIR"
install -m 0644 *.ttf "$FONT_DIR"

fc-cache -f "$FONT_DIR"

echo "installed $FONT to $FONT_DIR"
