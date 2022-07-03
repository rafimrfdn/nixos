#! /bin/sh 

#picom &
#xset r rate 300 50 &
#xset mouse 5 1 &
#feh --bg-fill --randomize ~/Pictures/wp/* &
##conky -b &
#~/.scripts/reducetty.sh &
#xrdb -merge .Xresources &
#while true;do
#	copyq &
#	slstatus &
#	dbus-launch --exit-with-session dwm > /dev/null 2>&1
#done
#exec dwm

setxkbmap us &
dbus-launch --exit-with-session bspwm
