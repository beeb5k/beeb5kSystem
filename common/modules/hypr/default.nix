{
  homeManager,
  inputs,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.hyprland;
in
{
  imports =
    if homeManager then
      [
        ./general.nix
        ./animations.nix
        ./rules.nix
        ./keys.nix
        # ./hypridle.nix
        # ./hyprlock.nix
      ]
    else
      [ ];

  options.hyprland = {
    enable = mkEnableOption "enable hyprland";
    animations = mkEnableOption "animations";
    xwayland = mkEnableOption "xwayland";
    decoration = {
      shadows = {
        enable = mkEnableOption "shadows";
      };
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
          default = 1.0;
        };
      };
      rounding = mkOption {
        type = types.int;
        default = 0;
        description = "Border radius";
      };
    };
    layout = mkOption {
      type = types.enum [
        "dwindle"
        "master"
        "scrolling"
      ];
      description = "window layout";
    };
  };

  config = lib.mkIf cfg.enable (
    if !homeManager then
      {
        programs.hyprland = {
          enable = true;
          package = pkgs.hyprland;
          withUWSM = false;
          xwayland.enable = cfg.xwayland;
        };
      }
    else
      { }
  );
}
