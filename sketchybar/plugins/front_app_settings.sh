#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# this script opens the settings menu of the focused application cmd+,

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO settings" click_script="osascript -e 'tell application \"System Events\" to keystroke \",\" using command down'; sketchybar --set front_app popup.drawing=off"
fi
