#!/bin/sh
setxkbmap pt &
#xrdb ~/.Xresources &
#nitrogen --restore &
bgs ~/Imagens/Wallpaper/wallhaven-nkvg86.png &
#urxvtd --quiet --opendisplay --fork &
#xinput set-prop 10 341 1 &
xset r rate 200 30 &
#udiskie &
#picom &
#pipewire &
#exec dbus-run-session spectrwm
brightnessctl s 11% &
gammastep -l 38.7:-27.2 -t 6500:4500 -g 0.8 -m randr &
#pulseaudio --start &
pipewire &
exec dbus-run-session spectrwm
