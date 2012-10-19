







#!/bin/sh
xrandr --output LVDS1 --mode 1024x576 --pos 0x1080 --rotate normal --output VGA1 --mode 1920x1080 --pos 0x0 --rotate normal

killall -9 trayer
xmonad --restart
sleep 2

trayer --edge top --align right --SetDockType true --SetPartialStrut true --widthtype request --expand true --height 14 --tint 0x000000 &
