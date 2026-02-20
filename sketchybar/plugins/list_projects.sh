#!/bin/bash

GREEN_BG=0xFF6fffd4 #6fffd4FF
GREEN_FG=0xFF23473e #23473eFF
PDIR="$HOME/Projects"
PLIST=$(fd --type d --hidden --max-depth 1 '.' $PDIR | sed 's/ /\\ /g')

for PPATH in "$PLIST"; do
  echo "$PPATH" >>"$HOME/sketchybar.log"
  PNAME=$(basename "$PPATH")
  echo "$PNAME" >>"$HOME/sketchybar.log"

  if [ -d "$PPATH" ]; then
    PSAFENAME=$(echo "$PNAME" | sed 's/[^a-zA-Z0-9_]/_/g')
    echo "$PSAFENAME" >>"$HOME/sketchybar.log"

    PCLICK="~/.local/bin/neovim-ide \"$PPATH\" \"$PSAFENAME\"; sketchybar --set projects popup.drawing=toggle"
    PICON=""

    if [ -d "$PPATH/.git" ]; then
      if [ -d "$PPATH/$PNAME.xcodeproj" ]; then
        PICON=""
      else
        if [ -d "$PPATH/node_modules" ]; then
          PICON=""
        else
          if [ -f "$PPATH/wp-config.php" ]; then
            PICON=""
          else
            if [ -f "$PPATH/tsconfig.json" ]; then
              PICON=""
            else
              PICON=""

              if [ ! -f "$PPATH/README.md" ]; then
                PCLICK="open -a Finder \"$PPATH\"; sketchybar --set projects popup.drawing=toggle"
                SPLIST=$(fd --type d --hidden --max-depth 1 '.' "$PPATH" | sed 's/ /\\ /g')
                echo "$SPLIST" >>"$HOME/sketchybar.log"

                for SPPATH in $SPLIST; do
                  SNAME=$(basename $SPPATH)
                  echo "$SPPATH" >>"$HOME/sketchybar.log"

                  if [ -d "$SPPATH" ]; then
                    SPSAFENAME=$(echo $SNAME | sed 's/[^a-zA-Z0-9_]/_/g')
                    SCLICK="~/.local/bin/neovim-ide \"$SPPATH\" \"$SPSAFENAME\"; sketchybar --set projects popup.drawing=toggle"
                    SICON=""

                    if [ -d "$SPPATH/.git" ]; then
                      if [ -d "$SPPATH/$SNAME.xcodeproj" ]; then
                        SICON=""
                      else
                        if [ -d "$SPPATH/node_modules" ]; then
                          SICON=""
                        else
                          if [ -f "$SPPATH/wp-config.php" ]; then
                            SICON=""
                          else
                            if [ -f "$SPPATH/tsconfig.json" ]; then
                              SICON=""
                            else
                              SICON=""
                            fi
                          fi
                        fi
                      fi
                    else
                      SICON=""
                    fi

                    sproject=(
                      label="$SNAME"
                      icon="󱞩 $SICON"
                      icon.color=$GREEN_FG
                      icon.padding_left=0
                      icon.padding_right=8
                      label.color=$GREEN_FG
                      padding_left=16
                      padding_right=16
                      background.color=0xFF5bb3a3 #5bb3a3FF
                      background.drawing=off
                      script="$PLUGIN_DIR/hover.sh"
                      click_script="$SCLICK"
                    )

                    sketchybar --add item sproject."$SPSAFENAME" popup.projects \
                      --set sproject."$SPSAFENAME" "${sproject[@]}" \
                      --subscribe sproject."$SPSAFENAME" mouse.entered mouse.exited
                  fi
                done

                echo "sproject.$SPSAFENAME" >>"$HOME/sketchybar.log"
              fi
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

    sketchybar --add item project."$PSAFENAME" popup.projects \
      --set project."$PSAFENAME" "${project[@]}" \
      --subscribe project."$PSAFENAME" mouse.entered mouse.exited
  fi

  echo "project.$PSAFENAME" >>"$HOME/sketchybar.log"
done
