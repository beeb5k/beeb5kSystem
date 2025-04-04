{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    pcmanfm
  ];

  programs.lf.enable = true;
}
