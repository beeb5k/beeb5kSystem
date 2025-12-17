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

      bold = mkOption {
        type = types.bool;
        default = false;
        description = "Force bold text";
      };
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
              if cfg.font.bold
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
          config-file = ["~/.config/ghostty/config-dankcolors"];

          font-family = cfg.font.family;
          font-size = cfg.font.size;
          window-padding-x = cfg.window.padding-x;
          window-padding-y = cfg.window.padding-y;

          font-feature = ["calt" "liga" "dlig" "cv10" "cv06" "ss02" "ss03"];
          bold-is-bright = cfg.font.bold;
          gtk-titlebar = false;
          gtk-single-instance = false;
          gtk-tabs-location = "bottom";
          gtk-wide-tabs = false;
          resize-overlay = "never";
          copy-on-select = false;
          confirm-close-surface = false;
          mouse-hide-while-typing = true;
          custom-shader-animation = "always";
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
          general = {
            import = ["~/.config/alacritty/dank-theme.toml"];
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
