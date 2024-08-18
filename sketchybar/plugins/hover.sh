#!/bin/sh

if [[ "$SENDER" == "mouse.entered" ]]; then
  sketchybar --set $NAME background.drawing=on
else
  if [[ "$SENDER" == "mouse.exited" ]]; then
    sketchybar --set $NAME background.drawing=off
  fi
fi
