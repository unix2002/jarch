#!/bin/bash

# Check if the script is already running
# if pgrep -x "loop_pngs.sh" >/dev/null; then
#     echo " "
# else
#     # Start the script
#     /home/joseph/.background/loop_pngs.sh /home/joseph/.background/bg &
#     disown
# fi

xbindkeys &
xmodmap /home/joseph/.Xmodmap &
sleep 2
xwinwrap -b -sp -fs -nf -ov -- gifview -w WID /home/joseph/.background/gifs/fountain_pen_vibe.gif -a &
mpd &