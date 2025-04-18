{ pkgs, unstable, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    targets.firefox.enable = false;
    targets.waybar.enable = false;
    targets.kde.enable = false;
    targets.gnome.enable = false;
    base16Scheme = {
      base00 = "181616";
      base01 = "0d0c0c";
      base02 = "2d4f67";
      base03 = "a6a69c";
      base04 = "7fb4ca";
      base05 = "c5c9c5";
      base06 = "938aa9";
      base07 = "c5c9c5";

      base08 = "c4746e";
      base09 = "e46876";
      base0A = "c4b28a";
      base0B = "8a9a7b";
      base0C = "8ea4a2";
      base0D = "8ba4b0";
      base0E = "a292a3";
      base0F = "7aa89f";
    };

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

      sansSerif = {
        package = unstable.adwaita-fonts;
        name = "Adwaita Sans";
      };

      sizes = {
        applications = 12;
        desktop = 10;
        popups = 12;
        terminal = 13;
      };
    };

    opacity = {
      terminal = 0.95;
    };
  };
}
