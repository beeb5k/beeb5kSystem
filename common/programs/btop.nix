<<<<<<< HEAD
=======
{ lib, config, ... }:
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
{
  programs.btop = {
    enable = true;
    settings = {
<<<<<<< HEAD
      color_theme = "matugen";
=======
      color_theme = lib.optionalString config.beeMods.matugen.enable "matugen";
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      rounded_corners = false;
    };
  };
}
