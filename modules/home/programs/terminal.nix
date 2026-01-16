{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.terminal;
in {
  options.terminal = {
    emulator = mkOption {
      type = types.enum ["foot" "ghostty" "alacritty" "none"];
      description = "The terminal emulator to enable.";
    };

    font = {
      family = mkOption {
        type = types.str;
      };

      size = mkOption {
        type = types.float;
      };

      bright_color_is_bold = mkOption {
        type = types.bool;
        default = false;
        description = "Force bold text";
      };

      ligatures = mkEnableOption "Only supported by ghostty";
    };

    window = {
      padding-x = mkOption {
        type = types.int;
        description = "Window padding x axis (pixels).";
      };

      padding-y = mkOption {
        type = types.int;
        description = "Window padding y axis (pixels).";
      };
    };
  };

  config = mkMerge [
    (mkIf (cfg.emulator == "foot") {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            include = ["/home/beeb5k/.config/foot/dank-colors.ini"];

            pad = "${toString cfg.window.padding-x}x${toString cfg.window.padding-y}";
            font = "${cfg.font.family}:size=${toString cfg.font.size}";

            dpi-aware = "no";
            bold-text-in-bright =
              if cfg.font.bright_color_is_bold
              then "yes"
              else "no";
          };
          cursor = {
            beam-thickness = 1;
          };
          mouse = {
            hide-when-typing = "yes";
          };
          key-bindings = {};
        };
      };
    })

    (mkIf (cfg.emulator == "ghostty") {
      programs.ghostty = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          config-file = ["~/.config/ghostty/themes/dankcolors"];

          font-family = cfg.font.family;
          font-size = cfg.font.size;
          window-padding-x = cfg.window.padding-x;
          window-padding-y = cfg.window.padding-y;
          font-feature =
            ["cv10" "cv06" "ss02" "ss03"]
            ++ (
              if cfg.font.ligatures
              then [
                "calt"
                "liga"
                "dlig"
              ]
              else ["-calt" "-liga" "-dlig"]
            );
          bold-is-bright = cfg.font.bright_color_is_bold;
          gtk-titlebar = false;
          gtk-single-instance = true;
          gtk-tabs-location = "bottom";
          gtk-wide-tabs = false;
          resize-overlay = "never";
          copy-on-select = false;
          confirm-close-surface = false;
          mouse-hide-while-typing = true;
          window-inherit-working-directory = false;
        };
      };
    })

    (mkIf (cfg.emulator == "alacritty") {
      programs.alacritty = {
        enable = true;
        settings = {
          cursor = {
            thickness = 0.0;
          };
          debug = {
            prefer_egl = true;
          };
          colors = {
            draw_bold_text_with_bright_colors = cfg.font.bright_color_is_bold;
          };
          mouse = {
            hide_when_typing = true;
          };
          general = {
            import = ["~/.cache/wal/alacritty-colors.toml"];
          };
          window = {
            padding = {
              y = cfg.window.padding-y;
              x = cfg.window.padding-x;
            };
            dimensions = {
              lines = 75;
              columns = 100;
            };
          };
          font = {
            normal.family = cfg.font.family;
            size = cfg.font.size;
          };
        };
      };
    })
  ];
}
