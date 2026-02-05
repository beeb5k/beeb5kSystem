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
  imports = with inputs.self.homeModules; [
    inputs.beeb5kvim.homeModules.default
    programs
    mango
    dwm
    scripts
    ../users.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  mango = {
    enable = true;
    noctalia-shell = false;
  };
  dwm.enable = true;

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
    emulator = {
      default = "foot";
      foot = true;
      alacritty = false;
      ghostty = false;
    };
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

  programs.mangohud.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = config.terminal.emulator.default;
  };

  home.packages = with pkgs; [
    opencode
    imagemagick
    pavucontrol
    matugen
    brightnessctl
    totem
    imv
    bluetui
    iamb
    thunderbird
    # (discord.override {
    #   withMoonlight = true;
    #   withOpenASAR = true;
    #   withTTS = false;
    # })
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
