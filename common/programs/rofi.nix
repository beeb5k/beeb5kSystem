{
  config,
  pkgs,
  lib,
  ...
}: {
  # remove this from here
  services.clipcat = {
    enable = config.bspwm.enable;
    daemonSettings = {
      daemonize = true;
      max_history = 50;
      desktop_notification = {
        enable = false;
      };
    };
    menuSettings = {
      server_endpoint = "/run/user/1000/clipcat/grpc.sock";
      finder = "rofi";

      rofi = {
        menu_length = 10;
        line_length = 100;
        menu_prompt = "Clipboard";
        extra_arguments = [];
      };
    };
  };

  programs.rofi = {
    enable = true;
    font = "Lilex Nerd Font";
    plugins = with pkgs; [rofi-calc rofi-emoji];
    theme = "~/.config/rofi/themes/config.rasi";
  };

  # custom scripts
  home.packages = [
    pkgs.rofi-bluetooth
    pkgs.rofi-network-manager
    pkgs.rofi-power-menu
    (pkgs.writeShellScriptBin "wall-picker" ''
      # Define the directory containing wallpapers
      WALL_DIR="$HOME/Pictures/wallpapers"

      # Function to generate a list of wallpapers formatted for Rofi
      # Output format: filename\0icon\x1f/absolute/path
      list_wallpapers() {
          for wall in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
              if [ -f "$wall" ]; then
                  name=$(basename "$wall")
                  echo -en "$name\0icon\x1f$wall\n"
              fi
          done
      }

      # --- 1. Selection Menu ---
      # Launch Rofi in dmenu mode with a grid layout to display wallpaper previews
      SELECTED=$(list_wallpapers | rofi -dmenu -i -p "Wallpaper" \
          -show-icons \
          -theme-str 'element { orientation: vertical; padding: 15px; }' \
          -theme-str 'element-icon { size: 10em; horizontal-align: 0.5; }' \
          -theme-str 'element-text { horizontal-align: 0.5; }' \
          -theme-str 'listview { columns: 3; lines: 2; }' \
          -theme-str 'window { width: 50%; }')

      # Proceed only if a selection was made (user didn't press Escape)
      if [ -n "$SELECTED" ]; then
          FULL_PATH="$WALL_DIR/$SELECTED"

          # --- 2. Apply Wallpaper (Display Protocol Detection) ---

          # Check if running on Wayland
          if [ -n "$WAYLAND_DISPLAY" ]; then

              # Backend A: swaybg (Static image)
              if command -v swaybg >/dev/null 2>&1; then
                  # Kill existing instances to prevent stacking or conflicts
                  pkill swaybg

                  # Create a persistence script for the next login
                  echo "swaybg -i \"$FULL_PATH\" -m fill &" > "$HOME/.swaybg.sh"

                  # Apply immediately
                  sh "$HOME/.swaybg.sh"

              # Backend B: swww (Animated/Transition support)
              elif command -v swww >/dev/null 2>&1; then
                  swww img "$FULL_PATH" --transition-type grow

              # Fallback: No backend found
              else
                  dunstify "Error: No Wayland wallpaper tool found (swaybg/swww)"
              fi

              # Cross-Compatibility: Update X11 config (.fehbg) from Wayland session
              # This ensures the wallpaper persists if you switch to an X11 window manager (like dwm/bspwm)
              echo "feh --no-fehbg --bg-fill '$FULL_PATH'" > ~/.fehbg

          # Check if running on X11
          else
              # Apply immediately using feh
              feh --bg-fill "$FULL_PATH"

              # Cross-Compatibility: Update Wayland config from X11 session
              # Note: We only generate for swaybg here as swww manages its own daemon/caching
              echo "swaybg -i \"$FULL_PATH\" -m fill &" > "$HOME/.swaybg.sh"
          fi

          # --- 3. System Theming ---
          # Generate Material Design colors (matugen) and terminal colors (hellwal)
          # matches the system theme to the new wallpaper
          matugen image "$FULL_PATH" && hellwal --skip-term-colors -q -i "$FULL_PATH"
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

  # Dont scroll its just rofi theme
  xdg.configFile = {
    "rofi/themes/config.rasi" = {
      enable = true;
      text =
        # rasi
        ''
          /**
           *
           * Author : Aditya Shakya (adi1090x)
           * Github : @adi1090x
           *
           * Rofi Theme File
           * Rofi Version: 1.7.3
           **/

          /*****----- Configuration -----*****/
          configuration {
          	modi:                       "drun";
              show-icons:                 true;
              display-drun:               "drun";
              display-run:                "";
              display-filebrowser:        "";
              display-window:             "";
            font: "Lilex Nerd Font 12";
          	drun-display-format:        "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
          	window-format:              "{w} · {c} · {t}";
          }

          /*****----- Global Properties -----*****/
          @import                          "shared/colors.rasi"

          * {
              border-colour:               var(selected);
              handle-colour:               var(selected);
              background-colour:           var(background);
              foreground-colour:           var(foreground);
              alternate-background:        var(background-alt);
              normal-background:           var(background);
              normal-foreground:           var(foreground);
              urgent-background:           var(urgent);
              urgent-foreground:           var(background);
              active-background:           var(active);
              active-foreground:           var(background);
              selected-normal-background:  var(selected);
              selected-normal-foreground:  var(background);
              selected-urgent-background:  var(active);
              selected-urgent-foreground:  var(background);
              selected-active-background:  var(urgent);
              selected-active-foreground:  var(background);
              alternate-normal-background: var(background);
              alternate-normal-foreground: var(foreground);
              alternate-urgent-background: var(urgent);
              alternate-urgent-foreground: var(background);
              alternate-active-background: var(active);
              alternate-active-foreground: var(background);
          }

          /*****----- Main Window -----*****/
          window {
              /* properties for window widget */
              transparency:                "real";
              location:                    center;
              anchor:                      center;
              fullscreen:                  false;
              width:                       600px;
              x-offset:                    0px;
              y-offset:                    0px;

              /* properties for all widgets */
              enabled:                     true;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              cursor:                      "default";
              background-color:            @background-colour;
          }

          /*****----- Main Box -----*****/
          mainbox {
              enabled:                     true;
              spacing:                     0px;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px 0px 0px 0px;
              border-color:                @border-colour;
              background-color:            transparent;
              children:                    [ "inputbar", "listview" ];
          }

          /*****----- Inputbar -----*****/
          inputbar {
              enabled:                     true;
              spacing:                     0px;
              margin:                      0px;
              padding:                     0px;
              border:                      0px 0px 1px 0px;
              border-radius:               0px;
              border-color:                @alternate-background;
              background-color:            @background-colour;
              text-color:                  @foreground-colour;
              children:                    [ "prompt", "entry" ];
          }

          prompt {
              enabled:                     true;
              padding:                     15px;
              border:                      0px 1px 0px 0px;
              border-radius:               0px;
              border-color:                @alternate-background;
              background-color:            inherit;
              text-color:                  inherit;
          }
          textbox-prompt-colon {
              enabled:                     true;
              expand:                      false;
              str:                         "::";
              background-color:            inherit;
              text-color:                  inherit;
          }
          entry {
              enabled:                     true;
              padding:                     15px;
              background-color:            inherit;
              text-color:                  inherit;
              cursor:                      text;
              placeholder:                 "";
              placeholder-color:           inherit;
          }

          /*****----- Listview -----*****/
          listview {
              enabled:                     true;
              columns:                     1;
              lines:                       8;
              cycle:                       true;
              dynamic:                     true;
              scrollbar:                   false;
              layout:                      vertical;
              reverse:                     false;
              fixed-height:                true;
              fixed-columns:               true;

              spacing:                     0px;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              background-color:            transparent;
              text-color:                  @foreground-colour;
              cursor:                      "default";
          }
          scrollbar {
              handle-width:                5px ;
              handle-color:                @handle-colour;
              border-radius:               0px;
              background-color:            @alternate-background;
          }

          /*****----- Elements -----*****/
          element {
              enabled:                     true;
              spacing:                     10px;
              margin:                      0px;
              padding:                     8px 15px;
              border:                      0px 0px 1px 0px;
              border-radius:               0px;
              border-color:                @alternate-background;
              background-color:            transparent;
              text-color:                  @foreground-colour;
              cursor:                      pointer;
          }
          element normal.normal {
              background-color:            var(normal-background);
              text-color:                  var(normal-foreground);
          }
          element normal.urgent {
              background-color:            var(urgent-background);
              text-color:                  var(urgent-foreground);
          }
          element normal.active {
              background-color:            var(active-background);
              text-color:                  var(active-foreground);
          }
          element selected.normal {
              background-color:            var(alternate-background);
              text-color:                  var(foreground-colour);
          }
          element selected.urgent {
              background-color:            var(selected-urgent-background);
              text-color:                  var(selected-urgent-foreground);
          }
          element selected.active {
              background-color:            var(selected-active-background);
              text-color:                  var(selected-active-foreground);
          }
          element alternate.normal {
              background-color:            var(alternate-normal-background);
              text-color:                  var(alternate-normal-foreground);
          }
          element alternate.urgent {
              background-color:            var(alternate-urgent-background);
              text-color:                  var(alternate-urgent-foreground);
          }
          element alternate.active {
              background-color:            var(alternate-active-background);
              text-color:                  var(alternate-active-foreground);
          }
          element-icon {
              background-color:            transparent;
              text-color:                  inherit;
              size:                        32px;
              cursor:                      inherit;
          }
          element-text {
              background-color:            transparent;
              text-color:                  inherit;
              highlight:                   inherit;
              cursor:                      inherit;
              vertical-align:              0.5;
              horizontal-align:            0.0;
          }

          /*****----- Mode Switcher -----*****/
          mode-switcher{
              enabled:                     true;
              spacing:                     10px;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              background-color:            transparent;
              text-color:                  @foreground-colour;
          }
          button {
              padding:                     10px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              background-color:            @alternate-background;
              text-color:                  inherit;
              cursor:                      pointer;
          }
          button selected {
              background-color:            var(selected-normal-background);
              text-color:                  var(selected-normal-foreground);
          }

          /*****----- Message -----*****/
          message {
              enabled:                     true;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px 0px 0px 0px;
              border-color:                @border-colour;
              background-color:            transparent;
              text-color:                  @foreground-colour;
          }
          textbox {
              padding:                     10px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              background-color:            @alternate-background;
              text-color:                  @foreground-colour;
              vertical-align:              0.5;
              horizontal-align:            0.0;
              highlight:                   none;
              placeholder-color:           @foreground-colour;
              blink:                       true;
              markup:                      true;
          }
          error-message {
              padding:                     0px;
              border:                      0px solid;
              border-radius:               0px;
              border-color:                @border-colour;
              background-color:            @background-colour;
              text-color:                  @foreground-colour;
          }
        '';
    };
  };
}
