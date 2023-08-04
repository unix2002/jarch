#!/bin/bash
# This program is run everytime xmonad is run.
# It is located at /home/<usr>/.autostart.sh

# These commands maps my escape key to caps-lock and vise versa.
xbindkeys &
xmodmap /home/joseph/.Xmodmap &

# These commands set a gif as my background using xwinwrap.
sleep 2
xwinwrap -b -sp -fs -nf -ov -- gifview -w WID /home/joseph/.background/gifs/fountain_pen_vibe.gif -a &

# This command start my music player deamon.
mpd &