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
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

    # config = {
    #   common = {
    #     "org.freedesktop.impl.portal.FileChooser" = "kde";
    #   };
    #   Hyprland = {
    #     "org.freedesktop.impl.portal.FileChooser" = "kde";
    #   };
    # };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
  };

  home.packages = with pkgs; [
    pokeget-rs
    anyrun
    matugen
    firefox
    fzf
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
