{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    kdePackages.dolphin
    kdePackages.plasma-workspace
    kdePackages.qt6ct
  ];

  programs.yazi.enable = true;
}
