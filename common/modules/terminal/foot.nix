{
  lib,
  config,
}:
let
  cfg = config.beeMods.terminal;
in
{
  config = lib.mkIf cfg.foot {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          include = lib.optionals config.beeMods.matugen.enable [ "~/.config/foot/dank-colors.ini" ];

          pad = "${toString cfg.window.padding-x}x${toString cfg.window.padding-y} center";
          font = "${cfg.font.family}:size=${toString cfg.font.size}";

          dpi-aware = "no";
          # gamma-correct-blending = "yes";
          bold-text-in-bright = if cfg.font.bright_color_is_bold then "yes" else "no";
        };
        cursor = {
          beam-thickness = 1;
        };
        mouse = {
          hide-when-typing = "yes";
        };
        key-bindings = { };
      };
    };
  };
}
