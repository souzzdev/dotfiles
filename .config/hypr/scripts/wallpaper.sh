#!/bin/bash

WALL_DIR="/home/souza/Wallpaper"

SELECTED=$(for img in "$WALL_DIR"/*; do
    echo -en "$(basename "$img")\x00icon\x1f$img\n"
done | rofi -dmenu \
    -show-icons \
    -p "Wallpaper" \
    -theme ~/.config/rofi/launchers/type-2/style-2.rasi \
    -theme-str '
        window {
            width: 50%;
            height: 50%;
            location: center;
            anchor: center;
            border-radius: 12px;
        }
        listview {
            columns: 4;
            spacing: 12px;
        }
        element {
            orientation: vertical;
            padding: 8px;
        }
        element-icon {
            size: 120px;
        }
    ')

[ -z "$SELECTED" ] && exit

awww img "$WALL_DIR/$SELECTED" \
    --transition-type random \
    --transition-duration 1.0