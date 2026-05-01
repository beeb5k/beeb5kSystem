{
  homeManager,
  inputs,
  moduleNameSpace,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  args = {
    moduleNameSpace = "beeMods";
    inherit inputs homeManager;
  };
in
{
  imports = [
    (import ./mango args)
    (import ./hyprland args)
    (import ./dwm args)
  ];

  options.${moduleNameSpace}.windowManagers = {
    mango.enable = lib.mkEnableOption "Enable mangowm";
    dwm.enable = lib.mkEnableOption "Enable dwm";
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
    eyeCandy = {
      animations.enable = lib.mkEnableOption "Uiiiiiiiiiii";
      window = {
        blur = {
          enable = lib.mkEnableOption "Enable window blur";
          passes = lib.mkOption {
            type = lib.types.int;
            default = 1;
          };
          radius = lib.mkOption {
            type = lib.types.int;
            default = 10;
          };
        };
        shadows.enable = lib.mkEnableOption "Enable window drop shadows";
        borderRadius = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = "Border radius";
        };
        opacity = lib.mkOption {
          type = lib.types.number;
          default = 1.0;
          description = "Window opacity";
        };
      };
    };
  };
  config = (
    if homeManager then
      {
        home.packages = with pkgs; [
          wl-clipboard
          cliphist
          brightnessctl
        ];
      }
    else
      {
      }
  );

}
