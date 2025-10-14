{ systemState, username }:
{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  mikuCursor = pkgs.stdenv.mkDerivation {
    pname = "miku-cursor";
    version = "1.0";
    src = inputs.miku-cursor-src;
    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src/miku-cursor-linux $out/share/icons/miku-cursor
    '';
  };

in
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
    name = "miku-cursor";
    package = mikuCursor;
    size = 24;
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
    imagemagick
    grimblast
    brightnessctl
    mpv
    android-tools
    wl-clipboard
    fuzzel
    onefetch
    rustlings
    rustup
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
