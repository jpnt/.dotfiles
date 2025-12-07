#!/bin/sh
flatpak override --user --filesystem=xdg-data/themes
flatpak override --user --env=GTK_THEME=Adwaita:dark
flatpak override --user --env=QT_STYLE_OVERRIDE=Adwaita-Dark
