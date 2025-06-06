{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
    ./packages.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";

  home.stateVersion = "25.05";

  home.sessionVariables = {
    XCURSOR_SIZE = "16";
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    TerminalEmulator = "foot";
    TERM = "foot";
    BROWSER = "firefox";
  };

  programs.home-manager.enable = true;
}
