#!/bin/sh
EMPTYCOLOR=0x44b35b7b
DIRTYYCOLOR=0xDDb35b7b
VISIBLECOLOR=0xFF47242b

ALLSPACES=$(yabai -m query --spaces | jq -r '.[] | .index')
EMPTYSPACES=$(yabai -m query --spaces | jq -r '.[] | select(."last-window"==0) | .index')
VISIBLESPACE=$(yabai -m query --spaces | jq -r '.[] | select(."is-visible"==true) | .index')

for i in $ALLSPACES; do
  sketchybar --set space."$i" icon.color=$DIRTYYCOLOR
done

for i in $EMPTYSPACES; do
  sketchybar --set space."$i" icon.color=$EMPTYCOLOR
done

for i in $VISIBLESPACE; do
  sketchybar --set space."$i" icon.color=$VISIBLECOLOR
done

