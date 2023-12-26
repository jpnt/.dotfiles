#!/bin/sh
#
# Simple package installer for Debian
# 
# Installs a custom list of fine software
# Add or remove any software if you want.

terminal="rxvt-unicode xterm"
calculator="calc"
sysmonitor="htop sysstat acpi"
musicplayer="cmus"
rss="newsboat"
filemanager="pcmanfm tree"
web="w3m wget"
imageviewer="imv"
wallpaper="nitrogen"
mediaplayer="mplayer ffmpeg"
pdfviewer="zathura-pdf-poppler"
texteditor="vim"
audio="pulseaudio pulsemixer pavucontrol"
networking="network-manager"
convertdoc="pandoc"
office="libreoffice"
plot="gnuplot"
gtktheme="lxappearance gnome-themes-extra"
bittorrent="qbittorrent"
spectrwm="spectrwm suckless-tools scrot fonts-terminus xorg xinit arandr fonts-freefont-ttf"
debugtools="strace ngrep tcpdump linux-perf curl dstat wireshark wireshark-qt"

packages="$terminal $calculator $sysmonitor $musicplayer $rss $filemanager $web $imageviewer $wallpaper $mediaplayer $pdfviewer $texteditor $audio $networking $convertdoc $office $plot $gtktheme $bittorrent $spectrwm $debugtools"

echo "==================================="
echo "Installing packages in 5 seconds..."
echo "==================================="
echo "Packages: $packages"
sleep 5
echo "==================================="

# Update and install packages
sudo apt update && sudo apt -y install $packages
