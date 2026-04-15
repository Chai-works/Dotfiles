#!/bin/bash

PLAYER="mpv"

title=$(playerctl -p $PLAYER metadata title 2>/dev/null)

if [ -z "$title" ]; then
    echo '{"text":"No Music","class":"stopped"}'
    exit
fi

pos=$(playerctl -p $PLAYER position 2>/dev/null)
len=$(playerctl -p $PLAYER metadata mpris:length 2>/dev/null)

if [ -n "$len" ] && [ "$len" != "0" ]; then
    progress=$(awk "BEGIN {printf \"%.0f\", ($pos*1000000)/$len}")
else
    progress=0
fi

bar=$(awk -v p="$progress" 'BEGIN {
    n = int(p/10);
    s="";
    for(i=0;i<10;i++) s = s (i<n?"▓":"░");
    print s;
}')

echo "{\"text\":\"$title [$bar]\",\"class\":\"music\",\"percentage\":$progress}"
