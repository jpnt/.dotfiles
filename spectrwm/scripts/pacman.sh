#!/bin/sh

essential="networkmanager wget tree base-devel"
calculator="calc libqalculate"
sysmonitor="htop sysstat acpi"
musicplayer="cmus"
rss="newsboat"
filemanager="ranger pcmanfm"
webbrowser="w3m netsurf"
imageviewer="sxiv"
wallpaper="nitrogen"
mediaplayer="mplayer"
pdfviewer="zathura zathura-pdf-mupdf"
texteditor="vim nano"
audio="alsa-utils pulseaudio"
networking="net-tools"
convertdoc="pandoc"
office="libreoffice"
plot="gnuplot"
gtktheme="lxappearance"
bittorrent="qbittorrent"
spectrwm="spectrwm dmenu xorg-server xorg-xinit gnu-free-fonts"


packages="$essential $calculator $sysmonitor $musicplayer $rss $filemanager $web $imageviewer $wallpaper $pdfviewer $texteditor $audio $networking $convertdoc $office $plot $gtktheme $bittorrent $spectrwm"

echo "Installing packages in 5 seconds..."
echo "Packages: $packages"
sleep 5
echo "Installing the selected packages"

sudo pacman -Syu $packages --noconfirm
