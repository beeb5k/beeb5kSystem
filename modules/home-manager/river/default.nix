{ pkgs, config, ... }:
{
  imports = [
    ./swayidle.nix
    ./swaylock.nix
  ];

  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    extraSessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemd.variables = [
      "DISPLAY"
      "WAYLAND_DISPLAY=wayland-1"
      "XDG_CURRENT_DESKTOP=river"
      "NIXOS_OZONE_WL"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];
    extraConfig = builtins.readFile ./init.sh;
  };

  # install any river realated pkgs.
  home.packages = with pkgs; [
    rivercarro
    swayidle
  ];
}
