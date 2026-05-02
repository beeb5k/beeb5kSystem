{
  systemState,
  user,
}:
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = with inputs.self.homeModules; [
    ../common.nix
    beeMods
    programs
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    user-templates = {
      config = { };
      templates = {
        nvim = {
          input_path = "~/.config/matugen/templates/neovim.lua";
          output_path = "~/.config/nvim/colors/matugen.lua";
        };
        equibop = {
          input_path = "~/.config/matugen/templates/discord.css";
          output_path = "~/.config/equibop/themes/matugen-sys24.css";
        };
      };
    };
  };

  beeMods = {
    windowManagers = {
      dwm.enable = false;
      hyprland.enable = true;
      mango.enable = false;
      eyeCandy = {
        animations.enable = true;
        window = {
          blur.enable = true;
          blur.radius = 12;
          blur.passes = 3;
          shadows.enable = true;
        };
      };
    };
    matugen.enable = true;
    emacs.enable = false;
    terminal = {
      alacritty = true;
      default = "alacritty";
      font.family = "IosevkaInput";
      font.size = 11.0;
    };
  };

  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = config.beeMods.terminal.default;
    TERM = config.beeMods.terminal.default;
  };

  programs.home-manager.enable = true;

  home.stateVersion = systemState; # check flake.nix
}
