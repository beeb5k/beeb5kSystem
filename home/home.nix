{ pkgs, lib, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
    ./packages.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";
  services.swww.enable = true;
  home.stateVersion = "25.11";

  # beeb5kvim
  Neovim = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      lib.mkForce [
        kdePackages.xdg-desktop-portal-kde
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

    config = {
      common = {
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };
      Hyprland = {
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.size = 16;
    dotIcons.enable = true;
    hyprcursor.enable = true;
  };

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
      @import "colors.css";
    '';

    gtk4.extraCss = ''
      @import "colors.css";
    '';
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    BROWSER = "zen";
    JDTLS_WORKSPACE = "$HOME/.local/share/jdtls/workspace";
    JDTLS_CACHE = "$HOME/.cache/jdtls";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.home-manager.enable = true;
}
