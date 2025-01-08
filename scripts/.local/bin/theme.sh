#!/bin/sh

GTK_THEME="Numix"
QT5_THEME="Fusion"
QT6_THEME="Fusion"

set_gtk_theme() {
	if command -v gsettings > /dev/null; then
		gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
		gsettings set org.gnome.desktop.interface icon-theme "$GTK_THEME"
		echo "(LOG) GTK theme applied: $GTK_THEME"
	else
		echo "(WARN) GTK settings not applied: unsupported environment"
	fi
}

set_qt_theme() {
	if command -v qt5ct > /dev/null; then
		qt5ct --style "$QT5_THEME"
		echo "(LOG) QT5 theme applied: $QT5_THEME"
	else
		echo "(WARN) QT5 settings not applied: unsupported environment"
	fi

	if command -v qt6ct > /dev/null; then
		qt6ct --style "$QT6_THEME"
	else
		echo "(WARN) QT6 settings not applied: unsupported environment"
	fi
}

set_gtk_theme
set_qt_theme
