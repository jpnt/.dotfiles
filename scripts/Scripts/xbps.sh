#!/bin/sh
#
# Simple package installer for Void Linux
# 
# Installs a custom list of fine software
# Add or remove any software if you want.

terminal="rxvt-unicode xterm"
calculator="calc"
sysmonitor="htop sysstat acpi"
musicplayer="cmus"
rss="newsboat"
filemanager="pcmanfm vifm tree"
web="w3m wget"
imageviewer="imv"
wallpaper="nitrogen"
mediaplayer="mplayer ffmpeg"
pdfviewer="zathura-pdf-mupdf"
texteditor="vim"
audio="pulseaudio alsa-plugins-pulseaudio pulsemixer pavucontrol"
networking="NetworkManager"
convertdoc="pandoc"
office="libreoffice"
plot="gnuplot"
gtktheme="lxappearance gnome-themes-extra"
bittorrent="qbittorrent"
spectrwm="spectrwm dmenu scrot slock terminus-font xorg xinit xrandr arandr freefont-ttf"
debugtools="strace ngrep tcpdump perf curl dstat wireshark wireshark-qt"

packages="$terminal $calculator $sysmonitor $musicplayer $rss $filemanager $web $imageviewer $wallpaper $mediaplayer $pdfviewer $texteditor $audio $networking $convertdoc $office $plot $gtktheme $bittorrent $spectrwm $debugtools"

echo "==================================="
echo "Installing packages in 5 seconds..."
echo "==================================="
echo "Packages: $packages"
sleep 5
echo "==================================="

# Update and install packages
sudo xbps-install -Suy $packages
