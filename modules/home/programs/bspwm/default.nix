{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.bspwm;
in {
  imports = [
    ./keys.nix
    ./polybar.nix
    ./idle.nix
    ./scripts.nix
  ];

  options.bspwm = {
    enable = mkEnableOption "enable bspwm";
  };

  config = mkMerge [
    (
      mkIf cfg.enable {
        xsession.windowManager.bspwm = {
          enable = true;
          monitors = {
            "eDP" = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
          };

          rules = {
            "Alacritty" = {
              desktop = "1";
              follow = true;
            };
            "zen" = {
              desktop = "2";
              follow = true;
            };
            "vesktop" = {
              desktop = "3";
              follow = true;
            };
            "steam" = {
              desktop = "4";
              follow = true;
            };
          };

          settings = {
            border_width = 2;
            window_gap = 5;
            focus_follows_pointer = true;
          };

          startupPrograms = [
            "sh ~/.fehbg"
            "systemctl --user restart polybar"
            "xsetroot -cursor_name left_ptr"
          ];

          extraConfig = ''
            # Source the colors from Matugen
            [ -f ~/.config/bspwm/colors.sh ] && . ~/.config/bspwm/colors.sh

            # Apply the colors to borders
            bspc config focused_border_color "$COLOR_FOCUSED"
            bspc config normal_border_color "$COLOR_NORMAL"
          '';
        };

        home.packages = with pkgs; [
          feh
          maim
          slop
          xdotool
          xclip
          matugen
          pywal16
          imagemagick
          pavucontrol
          pulseaudio
          brightnessctl
          rofi-bluetooth
          rofi-network-manager
          rofi-power-menu
        ];
      }
    )
  ];
}
