#!/bin/sh
setxkbmap pt &
xrdb -merge ~/.Xresources &
nitrogen --restore &
exec spectrwm
