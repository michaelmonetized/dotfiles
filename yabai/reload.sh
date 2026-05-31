#!/bin/bash

yabai --stop-service
skhd --stop-service
yabai --start-service --config ~/.config/yabai/yabairc
sketchybar --reload
skhd --start-service --config ~/.config/skhd

exit $?

