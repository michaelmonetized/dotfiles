#!/bin/bash

GREEN_BG=0xFF5bb3a3 #5bb3a3FF
GREEN_FG=0xFF23473e #23473eFF

ProjectsDIR="$HOME/Projects"

while IFS= read -r ProjectDIR; do
  if [ -d "$ProjectDIR" ]; then
    ProjectTitle=$(basename "$ProjectDIR")

    ProjectLabel=$(echo "$ProjectTitle" | sed 's/[^a-zA-Z0-9_]/_/g')

    ProjectOpen="$HOME/.local/bin/neovim-ide $ProjectDIR $ProjectLabel; sketchybar --set projects popup.drawing=toggle"
    ProjectIcon=""

    if [ -d "$ProjectDIR/.git" ]; then
      if [ -d "$ProjectDIR/$ProjectTitle.xcodeproj" ]; then
        ProjectIcon=""
      else
        if [ -d "$ProjectDIR/node_modules" ]; then
          ProjectIcon=""
        else
          if [ -f "$ProjectDIR/wp-config.php" ]; then
            ProjectIcon=""
          else
            if [ -f "$ProjectDIR/tsconfig.json" ]; then
              ProjectIcon=""
            else
              ProjectIcon=""
            fi
          fi
        fi
      fi

      project=(
        label="$ProjectLabel"
        icon="$ProjectIcon"
        icon.color="$GREEN_FG"
        icon.padding_left=0
        icon.padding_right=8
        label.color="$GREEN_FG"
        padding_left=16
        padding_right=16
        background.color="$GREEN_BG"
        background.drawing=off
        script="$PLUGIN_DIR/hover.sh"
        click_script="$ProjectOpen"
      )

      sketchybar --add item project."$ProjectLabel" popup.projects \
        --set project."$ProjectLabel" "${project[@]}" \
        --subscribe project."$ProjectLabel" mouse.entered mouse.exited
    else
      if [ ! -f "$ProjectDIR/README.md" ]; then
        ProjectIcon=""
        ProjectOpen="open -a Finder $ProjectDIR; sketchybar --set projects popup.drawing=toggle"

        project=(
          label="$ProjectLabel"
          icon="$ProjectIcon"
          icon.color="$GREEN_FG"
          icon.padding_left=0
          icon.padding_right=8
          label.color="$GREEN_FG"
          padding_left=16
          padding_right=16
          background.color="$GREEN_BG"
          background.drawing=off
          script="$PLUGIN_DIR/hover.sh"
          click_script="$ProjectOpen"
        )

        sketchybar --add item project."$ProjectLabel" popup.projects \
          --set project."$ProjectLabel" "${project[@]}" \
          --subscribe project."$ProjectLabel" mouse.entered mouse.exited

        while IFS= read -r SubProjectDIR; do
          if [ -d "$SubProjectDIR" ]; then
            SubProjectTitle=$(basename "$SubProjectDIR")

            SubProjectLabel=$(echo "$SubProjectTitle" | sed 's/[^a-zA-Z0-9_]/_/g')

            SubProjectOpen="$HOME/.local/bin/neovim-ide $SubProjectDIR $SubProjectLabel; sketchybar --set projects popup.drawing=toggle"
            SubProjectIcon=""

            if [ -d "$SubProjectDIR/.git" ]; then
              if [ -d "$SubProjectDIR/$SubProjectTitle.xcodeproj" ]; then
                SubProjectIcon=""
              else
                if [ -d "$SubProjectDIR/node_modules" ]; then
                  SubProjectIcon=""
                else
                  if [ -f "$SubProjectDIR/wp-config.php" ]; then
                    SubProjectIcon=""
                  else
                    if [ -f "$SubProjectDIR/tsconfig.json" ]; then
                      SubProjectIcon=""
                    else
                      SubProjectIcon=""
                    fi
                  fi
                fi
              fi
            else
              if [ ! -f "$SubProjectDIR/README.md" ]; then
                SubProjectIcon=""
                SubProjectOpen="open -a Finder $SubProjectDIR; sketchybar --set projects popup.drawing=toggle"
              fi
            fi

            if [ -d "$SubProjectDIR/.git" ]; then
              sproject=(
                label="$SubProjectLabel"
                icon="󱞩 $SubProjectIcon"
                icon.color="$GREEN_FG"
                icon.padding_left=0
                icon.padding_right=8
                label.color="$GREEN_FG"
                padding_left=16
                padding_right=16
                background.color="$GREEN_BG"
                background.drawing=off
                script="$PLUGIN_DIR/hover.sh"
                click_script="$SubProjectOpen"
              )

              sketchybar --add item project."$SubProjectLabel" popup.projects \
                --set project."$SubProjectLabel" "${sproject[@]}" \
                --subscribe project."$SubProjectLabel" mouse.entered mouse.exited
            else
              if [ -f "$SubProjectDIR/README.md" ]; then
                sproject=(
                  label="$SubProjectLabel"
                  icon="󱞩 $SubProjectIcon"
                  icon.color="$GREEN_FG"
                  icon.padding_left=0
                  icon.padding_right=8
                  label.color="$GREEN_FG"
                  padding_left=16
                  padding_right=16
                  background.color="$GREEN_BG"
                  background.drawing=off
                  script="$PLUGIN_DIR/hover.sh"
                  click_script="$SubProjectOpen"
                )

                sketchybar --add item project."$SubProjectLabel" popup.projects \
                  --set project."$SubProjectLabel" "${sproject[@]}" \
                  --subscribe project."$SubProjectLabel" mouse.entered mouse.exited
              fi
            fi
          fi
        done < <(fd -t d --hidden --max-depth 1 '.' "$ProjectDIR")
      fi
    fi
  fi
done < <(fd -t d --hidden --max-depth 1 '.' "$ProjectsDIR")
