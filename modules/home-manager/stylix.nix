{ pkgs, ... }:
{
  stylix = {
    enable = true;
    # autoEnable = true;
    targets.firefox.enable = false;
    targets.waybar.enable = false;
    targets.kde.enable = false;
    targets.gnome.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    image = ../../wallpapers/wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.adwaita-fonts;
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
      terminal = 1.0;
    };
  };
}
