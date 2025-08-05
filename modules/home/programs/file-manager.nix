{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    kdePackages.dolphin
  ];

  programs.yazi.enable = true;
}
