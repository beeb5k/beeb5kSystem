{ lib, config, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.optionalString config.beeMods.matugen.enable "noctalia";
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      rounded_corners = false;
    };
  };
}
