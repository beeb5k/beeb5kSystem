{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    xfce.thunar
  ];

  programs.yazi.enable = true;
}
