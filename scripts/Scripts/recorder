#!/bin/sh
#
# FFmpeg screen recording script - recorder
# Usage: recorder p 
#        recorder a
#        recorder

FPS="30"
RES=$(xdpyinfo | grep dimensions | awk '{print $2}')

recorder ()
{
case $1 in 
	p)
		echo "=========================="
		echo "Recording using PulseAudio"
		echo "=========================="
		ffmpeg -f x11grab -s $RES -r $FPS -i :0.0 \
		-f pulse -ac 2 -i default -vcodec libx264 \
		-acodec aac -ab 128k -ar 44100 \
		-threads 0 $(date +%s).mkv
		;;

	a)
		echo "===================="
		echo "Recording using ALSA"
		echo "===================="
		ffmpeg -f x11grab -s $RES -r $FPS -i :0.0 \
		-f alsa -ac 2 -i default -vcodec libx264 \
		-acodec aac -ab 128k -ar 44100 \
		-threads 0 $(date +%s).mkv
		;;

	*)
		echo "======================="
		echo "Recording without audio"
		echo "======================="
		ffmpeg -f x11grab -s $RES -r $FPS -i :0.0 \
		-threads 0 $(date +%s).mkv
		;;
esac;
}

recorder $1
