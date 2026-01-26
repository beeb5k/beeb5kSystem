{config, ...}: {
  services.dunst = {
    enable = true;
    configFile = "~/.cache/matugen/dunstrc";
  };
}
