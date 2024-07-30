#!/bin/sh
setxkbmap pt &
#xrdb ~/.Xresources &
nitrogen --restore &
#urxvtd --quiet --opendisplay --fork &
#xinput set-prop 10 341 1 &
xset r rate 200 25 &
#udiskie &
#picom &
#pipewire &
#exec dbus-run-session spectrwm
brightnessctl s 11% &
gammastep -l 38.7:-27.2 -t 5700:3600 -g 0.8 -m randr &
exec spectrwm
