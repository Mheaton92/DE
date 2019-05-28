#!/bin/sh
# Bind keys
sxhkd &

#setting screen layout
xrandr --output DVI-D-0 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --mode 1366x768 --pos 1920x45 --rotate normal --output DP-1 --off

#Setting wallpaper and color scheme
feh --bg-scale /home/matthew/.config/wall.png
wal -c
wal -i /home/matthew/.config/wall.png

#Adding transparrency
#compton -b -d :0
compton -bcCG --shadow-radius 10 -l -10 -t -10 --shadow-red 0.8 --shadow-green 0.0 --shadow-blue 1.0 --shadow-exclude '!focused' &

sh ~/.scripts/startx/dwm_status.sh

#exec dwm
sh /home/matthew/.local/bin/startx/dwm_relaunch.sh
