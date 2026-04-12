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
with lib;
{
  imports = lib.optionals homeManager [
    (import ./foot.nix { inherit lib config; })
    (import ./ghostty.nix { inherit lib config; })
    (import ./alacritty.nix { inherit lib config; })
  ];

  options.${moduleNameSpace}.terminal = {
    default = mkOption {
      type = types.enum [
        "foot"
        "ghostty"
        "alacritty"
      ];
      default = "foot";
      description = "The terminal emulator to enable.";
    };
    foot = mkEnableOption "enable foot";
    alacritty = mkEnableOption "enable alacritty";
    ghostty = mkEnableOption "enable ghostty";

    font = {
      family = mkOption {
        type = types.str;
        default = "monospace";
      };
      size = mkOption {
        type = types.float;
        default = 13.0;
      };

      bright_color_is_bold = mkEnableOption "bright colors in bold font";

      ligatures = mkEnableOption "Only supported by ghostty";
    };

    window = {
      padding-x = mkOption {
        type = types.int;
        default = 10;
        description = "Window padding x axis (pixels).";
      };

      padding-y = mkOption {
        type = types.int;
        default = 10;
        description = "Window padding y axis (pixels).";
      };
    };
  };
}
