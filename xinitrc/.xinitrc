#!/bin/sh
setxkbmap pt &
#xrdb ~/.Xresources &
#nitrogen --restore &
sh ~/.screenlayout/dualscreen2.sh &
setroot ~/Imagens/Wallpaper/wallhaven-nkvg86.png &
#urxvtd --quiet --opendisplay --fork &
#xinput set-prop 10 341 1 &
xset r rate 200 30 &
xset s off -dpms &
#udiskie &
#picom &
brightnessctl s 11% &
gammastep -l 38.7:-27.2 -t 6500:4500 -g 0.8 -m randr &
#pulseaudio --start &
pipewire &
exec dbus-run-session spectrwm
