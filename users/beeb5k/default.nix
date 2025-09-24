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
  services.hyprpolkitagent.enable = true;

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
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    pokeget-rs
    matugen
    vesktop
    pavucontrol
    discord-ptb
    imv
    mako
    llvmPackages.libcxxClang
    papirus-icon-theme
    imagemagick
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
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
