#!/bin/sh
setxkbmap pt &
#xrdb ~/.Xresources &
nitrogen --restore &
#urxvtd --quiet --opendisplay --fork &
#xinput set-prop 10 341 1 &
xset r rate 200 25 &
#udiskie &
#picom &
pipewire &
exec dbus-run-session spectrwm
