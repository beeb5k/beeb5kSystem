{ systemState, username }:
{
  pkgs,
  lib,
  inputs,
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

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
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
    fuzzel
    matugen
    firefox
    fzf
    vesktop
    discord-ptb
    vscode-fhs
    imv
    mako
    llvmPackages.libcxxClang
    kdePackages.plasma-workspace
    kdePackages.okular
    papirus-icon-theme
    grimblast
    brightnessctl
    mpv
    cargo
    rustc
    pkgs.qt6.qtdeclarative
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
