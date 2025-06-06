{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    pcmanfm
  ];

  programs.yazi.enable = true;
}
