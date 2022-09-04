#!/bin/sh

function selectmonitor {
  options="Mirror\nExtend\nLaptop\nVGA\nDP"
  selected=$(echo -e $options | rofi -dmenu -i -theme-str '@import "gnomepowermenu.rasi"')
  if [[ $selected = "DP" ]]; then
    xrandr --output LVDS-1 --off --output VGA-1 --off --output HDMI-1 --off --output DP-1 --primary --mode 1920x1080 --rate 74.97 --pos 0x0 --rotate normal --output HDMI-2 --off --output HDMI-3 --off --output DP-2 --off --output DP-3 --off
  elif [[ $selected = "VGA" ]]; then
    xrandr --output LVDS-1 --off --output VGA-1 --primary --mode 1440x900 --rate 59.89 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output HDMI-3 --off --output DP-2 --off --output DP-3 --off
  elif [[ $selected = "Laptop" ]]; then
    xrandr --output LVDS-1 --primary --mode 1366x768 --rate 60.10 --pos 0x0 --rotate normal --output DP-1 --off --output VGA-1 --off
  elif [[ $selected = "Extend" ]]; then
    xrandr --output LVDS-1 --auto --rotate normal --pos 0x0 --output VGA-1 --auto --rotate normal --right-of LVDS-1 
  elif [[ $selected = "Mirror" ]]; then
    xrandr --output LVDS-1 --primary  --output VGA-1 --same-as LVDS-1
  fi
}
selectmonitor
