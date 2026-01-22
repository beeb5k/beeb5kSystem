{
  systemState,
  user,
}: {
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.beeb5kvim.homeModules.default
    inputs.self.homeModules.programs
    inputs.self.homeModules.mango
    ../users.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  mango.enable = true;

  beebvim = {
    enable = true;
    packageDefinitions.replace =
      builtins.mapAttrs (n: _: {pkgs, ...}: {
        categories = {
          clang = false;
          markdown = false;
        };
      })
      inputs.beeb5kvim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
  };

  terminal = {
    emulator = "foot"; # alacritty, foot, ghostty.
    font = {
      family = "Lilex Nerd Font";
      size = 12.0;
      bright_color_is_bold = false;
      ligatures = false; # only supported by ghostty
    };
    window = {
      padding-x = 10;
      padding-y = 10;
    };
  };

  home.sessionVariables = {};

  home.packages = with pkgs; [
    gimp3-with-plugins
    opencode
    obsidian
    imagemagick
    discord
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
