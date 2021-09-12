#!/bin/sh
setxkbmap pt &
xrdb ~/.Xresources &
nitrogen --restore &
exec spectrwm
