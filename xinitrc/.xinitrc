#!/bin/sh
setxkbmap pt &
xrdb ~/.Xresources &
nitrogen --restore &
urxvtd --quiet --opendisplay --fork &
exec spectrwm
