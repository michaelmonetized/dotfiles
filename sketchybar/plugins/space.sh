#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "$SELECTED" = "true" ]; then
  ICONCOLOR=0xFF47242b
else
  ICONCOLOR=0xFFb35b7b
fi

sketchybar --set "$NAME" icon.color="$ICONCOLOR"
