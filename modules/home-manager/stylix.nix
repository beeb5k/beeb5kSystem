{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    targets.firefox.enable = false;
    targets.waybar.enable = false;
    targets.kde.enable = false;
    targets.gnome.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mountain.yaml";
    polarity = "dark";
    image = ../../wallpapers/wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sizes = {
        applications = 12;
        desktop = 10;
        popups = 12;
        terminal = 11;
      };
    };

    opacity = {
      terminal = 1.0;
    };
  };
}
