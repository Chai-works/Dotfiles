#!/bin/bash

PLAYER="mpv"

status=$(playerctl -p $PLAYER status 2>/dev/null)

if [ "$status" = "Paused" ]; then
    title=$(playerctl -p $PLAYER metadata title 2>/dev/null)
    echo "{\"text\":\"  ${title}   ⏸\",\"class\":\"music paused\"}"
    exit
fi

[ "$status" != "Playing" ] && exit

title=$(playerctl -p $PLAYER metadata title 2>/dev/null)

pos=$(playerctl -p $PLAYER position 2>/dev/null)
len=$(playerctl -p $PLAYER metadata mpris:length 2>/dev/null)

# length from playerctl is in microseconds, position is in seconds
# so convert position to microseconds first
if [ -z "$pos" ] || [ -z "$len" ] || [ "$len" = "0" ]; then
    progress=0
else
    progress=$(awk "BEGIN {printf \"%.0f\", ($pos * 1000000 / $len) * 100}")
fi

bar_length=12

filled=$((progress * bar_length / 100))
empty=$((bar_length - filled))

filled_dots=$(printf '%.0s⬤ ' $(seq 1 $filled))
empty_dots=$(printf '%.0s⬤ ' $(seq 1 $empty))

bar="<span color='#cba6f7'>${filled_dots}</span><span color='#313244'>${empty_dots}</span>"

echo "{\"text\":\"  ${title}   ${bar}\",\"class\":\"music\",\"percentage\":${progress}}"
