{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hyprland;
in {
  imports = [
    ./general.nix
    ./animations.nix
    ./rules.nix
    ./key.nix
    # ./hypridle.nix
    # ./hyprlock.nix
  ];

  options.hyprland = {
    enable = mkEnableOption "enable hyprland";
    animations = mkEnableOption "animations";
    xwayland = mkEnableOption "xwayland";
    decoration = {
      shadows = mkEnableOption "shadows";
      blur = {
        enable = mkEnableOption "blur";
        size = mkOption {
          type = types.int;
          default = 4;
        };
        passes = mkOption {
          type = types.int;
          default = 3;
        };
        opacity = mkOption {
          type = types.float;
        };
      };
      rounding = mkOption {
        type = types.int;
        default = 0;
        description = "Border radius";
      };
    };
    layout = mkOption {
      type = types.enum ["dwindle" "master"];
      description = "window layout";
    };
  };

  config = mkMerge [
    (
      mkIf cfg.enable {
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs;
            lib.mkForce [
              xdg-desktop-portal-gtk
              xdg-desktop-portal-hyprland
            ];
        };
        home.packages = with pkgs; [
          imv
          wl-clipboard-rs
          imagemagick
          grimblast
          brightnessctl
          mpv
        ];
      }
    )
  ];
}
