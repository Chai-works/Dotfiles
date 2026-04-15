#!/bin/bash

MUSIC_DIR="$HOME/Music/kew"

choice=$(find "$MUSIC_DIR" -type f | sed 's|.*/||' | rofi -dmenu -i -theme ~/dotfiles/rofi/style.rasi -p "🎵")

[ -z "$choice" ] && exit

file=$(find "$MUSIC_DIR" -type f -name "$choice" | head -n 1)

pkill mpv 2>/dev/null
mpv --no-video "$file" &
