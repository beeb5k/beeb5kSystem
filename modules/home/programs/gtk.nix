{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };
    gtk3.extraCss = ''
      @import url("dank-colors.css");
    '';
    gtk4.extraCss = ''
      @import url("dank-colors.css");
    '';
  };
}
