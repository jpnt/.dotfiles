#!/bin/sh
# appmenu.sh

bottom="-b"
bar_font="-fn Terminus"
bar_color="-nb black"
bar_font_color="-nf rgb:a0/a0/a0"
bar_color_selected="-sb rgb:00/80/80"
bar_font_color_selected="-sf black"

dmenu_opts="$bottom $bar_font $bar_color $bar_font_color $bar_color_selected $bar_font_color_selected"

apps="firefox
chromium
libreoffice
spacefm
calibre
arandr"

chosen_app=$(printf "%s\n" "$apps" | dmenu $dmenu_opts)

[ -n "$chosen_app" ] && exec "$chosen_app" &
