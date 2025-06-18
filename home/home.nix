{ pkgs, lib, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
    ./packages.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";
  services.swww.enable = true;
  home.stateVersion = "25.05";

  # beeb5kvim
  Neovim = {
    enable = true;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    BROWSER = "firefox";
  };

  home.activation.appendGtkImport = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for version in 3.0; do
      dir="$HOME/.config/gtk-$version"
      gtk_config="$dir/gtk.css"
      colors_css="$dir/colors.css"
      import_line='@import "colors.css";'

      if [ -f "$colors_css" ]; then
        mkdir -p "$dir"
        [ -f "$gtk_config" ] || touch "$gtk_config"

        if ! grep -Fxq "$import_line" "$gtk_config"; then
          echo "$import_line" >> "$gtk_config"
        fi
      fi
    done
  '';

  programs.home-manager.enable = true;
}
