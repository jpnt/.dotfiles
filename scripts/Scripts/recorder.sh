#!/bin/sh
# FFmpeg screen recording script - recorder.sh
# Usage: recorder [OPTION]

FPS="30"
RES=$(xdpyinfo | grep dimensions | awk '{print $2}')
OUTPUT_DIR="${HOME}"
OUTPUT_FILE="${OUTPUT_DIR}/recording_$(date +%Y-%m-%d_%H-%M-%S).mkv"

AUDIO_CODEC="aac"
AUDIO_BITRATE="44100"
AUDIO_SETTINGS="-ac 2 -i default -acodec $AUDIO_CODEC -ar $AUDIO_BITRATE"

VIDEO_CODEC="libx264"
VIDEO_PRESET="veryfast"
VIDEO_CRF="28"
VIDEO_SETTINGS="-vcodec $VIDEO_CODEC -preset $VIDEO_PRESET -crf $VIDEO_CRF"

recorder ()
{
case $1 in
	p|pulseaudio)
		ffmpeg -f x11grab -s "$RES" -r "$FPS" -i :0.0 \
			-f pulse $AUDIO_SETTINGS \
			$VIDEO_SETTINGS -threads 0 "$OUTPUT_FILE"
		;;
	a|alsa)
		ffmpeg -f x11grab -s "$RES" -r $FPS -i :0.0 \
			-f alsa $AUDIO_SETTINGS \
			$VIDEO_SETTINGS -threads 0 "$OUTPUT_FILE"
		;;
	*)
		ffmpeg -f x11grab -s "$RES" -r "$FPS" -i :0.0 \
			$VIDEO_SETTINGS -threads 0 "$OUTPUT_FILE"
		;;
esac;
}

recorder $1
