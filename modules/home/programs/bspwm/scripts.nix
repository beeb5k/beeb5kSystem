{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "wall-picker" ''
      WALL_DIR="$HOME/Pictures/wallpapers"
      list_wallpapers() {
          for wall in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
              if [ -f "$wall" ]; then
                  name=$(basename "$wall")
                  echo -en "$name\0icon\x1f$wall\n"
              fi
          done
      }

      SELECTED=$(list_wallpapers | ${pkgs.rofi}/bin/rofi -dmenu -i -p "󰸉 Wallpaper" \
          -show-icons \
          -theme-str 'element { orientation: vertical; padding: 15px; }' \
          -theme-str 'element-icon { size: 10em; horizontal-align: 0.5; }' \
          -theme-str 'element-text { horizontal-align: 0.5; }' \
          -theme-str 'listview { columns: 3; lines: 2; }' \
          -theme-str 'window { width: 50%; }')

      if [ -n "$SELECTED" ]; then
          ${pkgs.feh}/bin/feh --bg-fill "$WALL_DIR/$SELECTED"
          sleep 0.2
          matugen image "$WALL_DIR/$SELECTED"
          wal -s -t -i "$WALL_DIR/$SELECTED"
      fi
    '')

    (pkgs.writeShellScriptBin "rofi-e-or-c" ''
      options="Clipboard\nEmoji"

      chosen=$(echo -en "$options" | rofi -dmenu -i -p "Quick Pick")
          # -theme-str 'window { width: 250px; }' \
          # -theme-str 'listview { lines: 2; }')

      case "$chosen" in
          *Clipboard)
              clipcat-menu
              ;;
          *Emoji)
              rofi -show emoji -modi emoji
              ;;
      esac
    '')
    (pkgs.writeShellScriptBin "rofi-b-or-n" ''
      options="NetworkManager\nBluetooth"

      chosen=$(echo -en "$options" | rofi -dmenu -i -p "Quick Pick")
          # -theme-str 'window { width: 250px; }' \
          # -theme-str 'listview { lines: 2; }')

      case "$chosen" in
          *Bluetooth)
              rofi-bluetooth
              ;;
          *NetworkManager)
              rofi-network-manager
              ;;
      esac
    '')
  ];
}
