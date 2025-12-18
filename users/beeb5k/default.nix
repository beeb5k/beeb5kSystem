{
  systemState,
  username,
}: {
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ../../modules/home
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.dank-material-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableDynamicTheming = true;
  };

  Neovim = {
    enable = true;
    packageDefinitions.replace =
      builtins.mapAttrs (n: _: {pkgs, ...}: {
        categories = {
          go = false;
        };
        extra = {
          pluginChoice = "fast";
        };
      })
      inputs.beeb5kvim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
  };

  terminal = {
    emulator = "alacritty"; # alacritty, foot, ghostty.
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

  hyprland = {
    enable = true;
    xwayland = false;
    animations = true;
    layout = "master"; # master or dwindle
    decoration = {
      shadows = false;
      rounding = 0;
      blur = {
        enable = false;
        passes = 3;
        size = 5;
        opacity = 0.90;
      };
    };
  };

  rust.enable = false;

  home.sessionVariables =
    {
    }
    // lib.optionalAttrs config.Neovim.enable {
      EDITOR = "nvim";
    };

  home.packages = with pkgs; [
    vesktop
    android-tools
    gimp3-with-plugins
    clang
    go
    opencode
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
