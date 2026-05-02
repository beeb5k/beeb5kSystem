<<<<<<< HEAD
=======
{ lib, config, ... }:
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
{
  programs.btop = {
    enable = true;
    settings = {
<<<<<<< HEAD
<<<<<<< HEAD
      color_theme = "matugen";
=======
      color_theme = lib.optionalString config.beeMods.matugen.enable "matugen";
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
=======
      color_theme = lib.optionalString config.beeMods.matugen.enable "noctalia";
>>>>>>> 33155f4 (stuff)
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      rounded_corners = false;
    };
  };
}
