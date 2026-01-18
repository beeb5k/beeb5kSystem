{config, ...}: {
  services.dunst = {
    enable = config.bspwm.enable;
    configFile = "~/.cache/matugen/dunstrc";
  };
}
