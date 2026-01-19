{
  homeManager,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.river;
  tagBindings = let
    tags = [1 2 4 8 16 32 64 128 256];
  in
    builtins.foldl' (
      acc: x: let
        i = toString (lib.lists.findFirstIndex (e: e == x) 0 tags + 1);
        mask = toString x;
      in
        acc
        // {
          "Super ${i}" = "set-focused-tags ${mask}";
          "Super+Shift ${i}" = "set-view-tags ${mask}";
          "Super+Control ${i}" = "toggle-focused-tags ${mask}";
          "Super+Shift+Control ${i}" = "toggle-view-tags ${mask}";
        }
    ) {}
    tags;
in {
  options.river = {
    enable = lib.mkEnableOption "river setup";
  };

  config = lib.mkIf cfg.enable (
    if homeManager
    then {
      wayland.windowManager.river = {
        enable = true;
        systemd.enable = true;
        extraConfig = ''
          rivertile -view-padding 4 -outer-padding 4 &
          pkill waybar; waybar &
          pkill swww-daemon; swww-daemon &

          riverctl map normal Super Print spawn 'sh -c "grim -g \"$(slurp)\" - | wl-copy"'
          riverctl map normal Print spawn 'sh -c "grim - | wl-copy"'

          export XDG_CURRENT_DESKTOP=river
          dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP
        '';

        settings = {
          # 1. Visuals
          border-color-focused = "0x93a1a1";
          border-color-unfocused = "0x586e75";
          background-color = "0x002b36";
          set-repeat = "50 300";
          focus-follows-cursor = "normal";
          set-cursor-warp = "on-focus-change";

          # 2. Layout Generator
          default-layout = "rivertile";
          spawn = [
          ];

          rule-add = {
            "-app-id" = {
              "'*'" = "ssd";
              "'alacritty'" = "tags 1";
              "'foot'" = "tags 1";

              "'firefox'" = "tags 2";
              "'zen'" = "tags 2";
              "'brave-browser'" = "tags 2";

              "'vesktop'" = "tags 4";
              "'discord'" = "tags 4";

              "'steam'" = "tags 8";
            };
          };
          # 3. Key Mappings
          map = {
            normal =
              {
                # --- Core ---
                "Super Return" = "spawn ${config.terminal.emulator}";
                "Super+Shift Return" = "zoom";
                "Super A" = "spawn 'rofi -show drun'";
                "Super B" = "spawn zen";
                "Super V" = "spawn rofi-e-or-c";
                "Super N" = "spawn rofi-b-or-n";
                "Super+Shift l" = "spawn 'rofi -show power-menu -modi power-menu:rofi-power-menu'";
                "Super Y" = "spawn wall-picker";
                "Super E" = "spawn nautilus";
                "Super F12" = "spawn 'rofi -show calc -modi calc -no-show-match -no-sort'";

                "Super Q" = "close";
                "Super+Shift E" = "exit";
                "Super Space" = "toggle-float";
                "Super F" = "toggle-fullscreen";

                # --- Focus & Swap ---
                "Super J" = "focus-view next";
                "Super K" = "focus-view previous";
                "Super+Shift J" = "swap next";
                "Super+Shift K" = "swap previous";

                # --- Layout Controls ---
                "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
                "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";
                "Super+Shift H" = "send-layout-cmd rivertile 'main-count +1'";
                "Super+Shift L" = "send-layout-cmd rivertile 'main-count -1'";

                # --- Audio (wpctl) ---
                "None XF86AudioRaiseVolume" = "spawn 'wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+'";
                "None XF86AudioLowerVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
                "None XF86AudioMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
                "None XF86AudioMicMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'";

                # --- Brightness ---
                "None XF86MonBrightnessUp" = "spawn 'brightnessctl set +5%'";
                "None XF86MonBrightnessDown" = "spawn 'brightnessctl set 5%-'";

                # --- Media Control ---
                "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
                "None XF86AudioNext" = "spawn 'playerctl next'";
                "None XF86AudioPrev" = "spawn 'playerctl previous'";
              }
              # Merge Tag Bindings
              // tagBindings;

            # --- Passthrough Mode ---
            passthrough = {
              "Super F11" = "enter-mode normal";
            };

            # --- Locked Mode (Media Keys work while locked) ---
            locked = {
              "None XF86AudioRaiseVolume" = "spawn 'wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+'";
              "None XF86AudioLowerVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
              "None XF86AudioMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
              "None XF86AudioMicMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'";

              "None XF86MonBrightnessUp" = "spawn 'brightnessctl set +5%'";
              "None XF86MonBrightnessDown" = "spawn 'brightnessctl set 5%-'";
              "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
              "None XF86AudioNext" = "spawn 'playerctl next'";
              "None XF86AudioPrev" = "spawn 'playerctl previous'";
            };
          };

          map-pointer = {
            normal = {
              "Super BTN_LEFT" = "move-view";
              "Super BTN_RIGHT" = "resize-view";
              "Super BTN_MIDDLE" = "toggle-float";
            };
          };
        };
      };

      home.packages = with pkgs; [wl-clipboard swww grim slurp];
    }
    else {
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-wlr
        ];
        config = {
          river = {
            default = ["gtk"];
            "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
            "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
          };
        };
      };
      programs.river-classic = {
        enable = true;
        extraPackages = [];
      };
    }
  );
}
