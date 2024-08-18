#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

VISIBLE=$(aerospace list-workspaces --monitor all --visible)
NONEMPTY=$(aerospace list-workspaces --monitor all --empty no)

# Set WORKSPACE to $NAME without the "workspace." prefix
WORKSPACE="${NAME#workspace.}"

# SET isEMPTY to true if WORKSPACE is in NONEMPTY
isEmpty=false
for i in $NONEMPTY; do
  if [ "$i" = "$WORKSPACE" ]; then
    isEmpty=true
    break
  fi
done

if [ "workspace.$VISIBLE" = "$NAME" ]; then
  ICONCOLOR=0xFF47242b #47242bFF
else
  if [ $isEmpty == true ]; then
    ICONCOLOR=0xDDb35b7b #b35b7bDD
  else
    ICONCOLOR=0x44b35b7b #b35b7b44
  fi
fi

sketchybar --set "$NAME" icon.color="$ICONCOLOR"
