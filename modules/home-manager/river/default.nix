{ pkgs, config, ... }:
{
  imports = [
    ./swayidle.nix
    ./swaylock.nix
  ];

  wayland.windowManager.river = {
    enable = true;
    extraConfig = builtins.readFile ./init.sh;
  };

  # install any river realated pkgs.
  home.packages = with pkgs; [
    rivercarro
    swayidle
  ];
}
