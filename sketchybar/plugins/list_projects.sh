#!/bin/bash

GREEN_BG=0xFF6fffd4 #6fffd4FF
GREEN_FG=0xFF23473e #23473eFF

for d in ~/Projects/*; do
  if [ -d "$d" ]; then
    PNAME=$(basename $d)
    SAFENAME=$(echo $PNAME | sed 's/[^a-zA-Z0-9-_]/-/g')
    PCLICK="~/.local/bin/neovim-ide \"$d\" \"$SAFENAME\"; sketchybar --set projects popup.drawing=toggle"

    if [ ! -f "$d/README.md" ]; then
      PCLICK="open -a Finder $d; sketchybar --set projects popup.drawing=toggle"
    fi

    if [ -f "$d/wp-config.php" ]; then
      PCLICK="~/.local/bin/neovim-ide \"$d\" \"$SAFENAME\"; sketchybar --set projects popup.drawing=toggle"
    fi

    PICON=""

    if [ -d "$d/.git" ]; then
      if [ -d "$d/$PNAME.xcodeproj" ]; then
        PICON=""
      else
        if [ -d "$d/node_modules" ]; then
          PICON=""
        else
          if [ -f "$d/wp-config.php" ]; then
            PICON=""
          else
            if [ -f "$d/tsconfig.json" ]; then
              PICON=""
            else
              PICON=""
            fi
          fi
        fi
      fi
    fi

    project=(
      label="$PNAME"
      icon="$PICON"
      icon.color=$GREEN_FG
      icon.padding_left=0
      icon.padding_right=8
      label.color=$GREEN_FG
      padding_left=16
      padding_right=16
      background.color=0xFF5bb3a3 #5bb3a3FF
      background.drawing=off
      script="$PLUGIN_DIR/hover.sh"
      click_script="$PCLICK"
    )

    sketchybar --add item project."$PNAME" popup.projects \
      --set project."$PNAME" "${project[@]}" \
      --subscribe project."$PNAME" mouse.entered mouse.exited
  fi

  echo "project.$PNAME" >>"/Users/michael/sketchybar.log"
done
