{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraCss = ''
      @import url("colors.css");
    '';
    gtk4.extraCss = ''
      @import url("colors.css");
    '';
  };
}
