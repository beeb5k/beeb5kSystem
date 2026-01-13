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
    inputs.dms.homeModules.dank-material-shell
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
          clang = true;
          misc = true;
        };
        extra = {
          pluginChoice = "fancy"; # fancy , fast , normal
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
    xwayland = true;
    animations = false;
    layout = "master"; # master or dwindle
    decoration = {
      shadows = false;
      rounding = 15;
      blur = {
        enable = false;
        passes = 3;
        size = 11;
        # opacity = 0.94;
        opacity = 1.0;
      };
    };
  };

  rust.enable = false;

  programs.mangohud = {
    enable = true;
    settings = {
      fps = true;
      frametime = true;
      device = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      vram = true;
      cpu_stats = true;
    };
  };

  home.sessionVariables =
    {
    }
    // lib.optionalAttrs config.Neovim.enable {
      EDITOR = "nvim";
    };

  home.packages = with pkgs; [
    (discord.override {
      withEquicord = true;
    })
    android-tools
    gimp3-with-plugins
    clang
    go
    opencode
    obsidian
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
