{
  lib,
  config,
}:
let
  cfg = config.beeMods.terminal;
in
{
  config = lib.mkIf cfg.alacritty {
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
          import = lib.optionals config.beeMods.matugen.enable [ "~/.config/alacritty/themes/noctalia.toml" ];
        };
        window = {
          dynamic_padding = true;
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
  };
}
