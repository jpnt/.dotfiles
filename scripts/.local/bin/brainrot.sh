#!/usr/bin/env bash

#echo "script-opts=ytdl_hook-ytdl_path=/usr/bin/yt-dlp" >> ~/.config/mpv/mpv.conf

VIDEOS="
https://www.youtube.com/watch?v=FpouoDphV-I
https://www.youtube.com/watch?v=V2VVvQaUhYI
https://www.youtube.com/watch?v=486_6hfXKgM
https://www.youtube.com/watch?v=NfcLKjFB59o
https://www.youtube.com/watch?v=DzzO1lhCJaI"

VIDEOS_ARRAY=($VIDEOS)

VIDEO=$(printf "%s\n" "${VIDEOS_ARRAY[@]}" | shuf -n 1)

mpv "$VIDEO"
