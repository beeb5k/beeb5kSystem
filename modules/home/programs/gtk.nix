{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraCss = ''
      @import "colors.css";
    '';
    gtk4.extraCss = ''
      @import "colors.css";
    '';
  };
}
