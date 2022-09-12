#!/bin/bash
YouTubeURL=$(whiptail --title "Artist Input Box" --inputbox "What YouTube URL are you taking music from?" 10 60 3>&1 1>&2 2>&3)

youtube-dl -f "bestaudio/best" -ciw -o "%(title)s.%(ext)s" -v --extract-audio --audio-quality 0 --audio-format mp3 $YouTubeURL