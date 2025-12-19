#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# VISIBLE=$(aerospace list-workspaces --monitor all --visible)
# NONEMPTY=$(aerospace list-workspaces --monitor all --empty no)
#
# # Set WORKSPACE to $NAME without the "workspace." prefix
# WORKSPACE="${NAME#workspace.}"
#
# # SET isEMPTY to true if WORKSPACE is in NONEMPTY
# isEmpty=false
# for i in $NONEMPTY; do
#   if [ "$i" = "$WORKSPACE" ]; then
#     isEmpty=true
#     break
#   fi
# done
#
# if [ "workspace.$VISIBLE" = "$NAME" ]; then
#   ICONCOLOR=0xFF47242b #47242bFF
# else
#   if [ $isEmpty == true ]; then
#     ICONCOLOR=0xDDb35b7b #b35b7bDD
#   else
#     ICONCOLOR=0x44b35b7b #b35b7b44
#   fi
# fi
#
#

ALL=$(yabai -m query --spaces | jq -r '.[]')
EMPTY=$(jq -r 'select(."last-window"==0 | .index' <<< "$ALL")
VISIBLE=$(jq -r 'select(."is-visible"==true | .index' <<< "$ALL")
WORKSPACE="${NAME#workspace.}"

INDECES=$(jq -r '.index' <<< "$ALL")
for i in $INDECES; do
  sketchybar --set "workspace.${INDECES[i]}" icon.color=0x44b35b7b #b35b7b44
done

for i in $EMPTY; do
  sketchybar --set "workspace.${EMPTY[i]}" icon.color=0xDDb35b7b #b35b7bDD
done

if [ "workspace.$VISIBLE" = "$NAME" ]; then
  ICONCOLOR=0xFF47242b #47242bFF
fi

sketchybar --set "workspace.$NAME" icon.color="$ICONCOLOR"

