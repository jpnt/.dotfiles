#!/bin/sh

screenshot ()
{
case $1 in
	full)	scrot -m	;;
	window)	scrot -s	;;
	*)			;;
esac;
}

screenshot $1
