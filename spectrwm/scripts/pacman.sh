#!/bin/sh
#
# Simple package installer for Arch Linux
#
# Installs a custom list of fine software
# Add or remove any software if you want.

terminal="rxvt-unicode xterm"
calculator="calc libqalculate"
sysmonitor="htop sysstat acpi"
musicplayer="cmus"
rss="newsboat"
filemanager="ranger pcmanfm tree"
web="w3m netsurf wget"
imageviewer="sxiv"
wallpaper="nitrogen"
mediaplayer="mplayer"
pdfviewer="zathura zathura-pdf-mupdf"
texteditor="vim leafpad"
audio="pulseaudio pulsemixer pulseaudio-alsa"
networking="net-tools networkmanager"
convertdoc="pandoc"
office="libreoffice"
plot="gnuplot"
gtktheme="lxappearance gnome-themes-extra"
bittorrent="qbittorrent"
spectrwm="spectrwm dmenu scrot slock xorg xorg-xinit xorg-xrandr arandr gnu-free-fonts"
debugtools="strace ngrep tcpdump perf curl dstat wireshark-cli wireshark-qt"

packages="$terminal $calculator $sysmonitor $musicplayer $rss $filemanager $web $imageviewer $wallpaper $mediaplayer $pdfviewer $texteditor $audio $networking $convertdoc $office $plot $gtktheme $bittorrent $spectrwm $debugtools"

echo "==================================="
echo "Installing packages in 5 seconds..."
echo "==================================="
echo "Packages: $packages"
sleep 5
echo "==================================="

# Update and install packages
sudo pacman -Syu $packages --noconfirm
