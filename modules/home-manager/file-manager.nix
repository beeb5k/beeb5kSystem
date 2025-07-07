{ pkgs, ... }:
{
  home.packages = with pkgs; [
    trash-cli
    nautilus
  ];

  programs.yazi.enable = true;
}
