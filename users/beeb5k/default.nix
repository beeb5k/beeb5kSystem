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
    XDG_MENU_PREFIX = "plasma-";
  };

  home.packages = with pkgs; [
    pokeget-rs
    matugen
    firefox
    fzf
    vesktop
    imv
    mako
    zig
    llvmPackages.libcxxClang
    kdePackages.plasma-workspace
    kdePackages.okular
    papirus-icon-theme
    grimblast
    brightnessctl
    mpv
    cargo
    android-tools
    wl-clipboard
    rustc
    fuzzel
    onefetch
    rustlings
    rust-analyzer
    pkgs.qt6.qtdeclarative
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
