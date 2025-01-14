#!/bin/sh

GTK_THEME="Numix"
QT5_THEME="Fusion"
QT6_THEME="Fusion"

set -e

set_gtk_theme() {
	gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
	gsettings set org.gnome.desktop.interface icon-theme "$GTK_THEME"
	echo "(LOG) GTK theme applied: $GTK_THEME"
}

set_qt_theme() {
	qt5ct --style "$QT5_THEME"
	echo "(LOG) QT5 theme applied: $QT5_THEME"

	qt6ct --style "$QT6_THEME"
	echo "(LOG) QT6 theme applied: $QT6_THEME"
}

set_gtk_theme
set_qt_theme
