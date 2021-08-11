#!/bin/sh

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
texteditor="vim nano"
audio="alsa-utils pulseaudio"
networking="net-tools networkmanager"
convertdoc="pandoc"
office="libreoffice"
plot="gnuplot"
gtktheme="lxappearance gnome-themes-extra"
bittorrent="qbittorrent"
spectrwm="spectrwm dmenu xorg-server xorg-xinit xorg-xrandr arandr gnu-free-fonts"


packages="$terminal $calculator $sysmonitor $musicplayer $rss $filemanager $web $imageviewer $wallpaper $mediaplayer $pdfviewer $texteditor $audio $networking $convertdoc $office $plot $gtktheme $bittorrent $spectrwm"

echo "Installing packages in 5 seconds..."
echo "Packages: $packages"
sleep 5
echo "Installing the selected packages"

sudo pacman -Syu $packages --noconfirm
