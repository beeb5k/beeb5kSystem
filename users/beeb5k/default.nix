{ systemState, username }:
{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  services.swww.enable = true;

  Neovim = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      lib.mkForce [
        kdePackages.xdg-desktop-portal-kde
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

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    XDG_MENU_PREFIX = "plasma-";
  };

  home.packages = with pkgs; [
    pokeget-rs
    anyrun
    matugen
    firefox
    fzf
    vesktop
    kdePackages.plasma-workspace
    kdePackages.gwenview
    kdePackages.okular
    papirus-icon-theme
    grimblast
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
