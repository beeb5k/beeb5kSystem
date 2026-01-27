{
  homeManager,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dwm;
in {
  imports =
    if homeManager
    then [
      ./picom.nix
    ]
    else [];

  options.dwm = {
    enable = lib.mkEnableOption "dwm setup";
  };

  config = lib.mkIf cfg.enable (
    if !homeManager
    then {
      environment.systemPackages = with pkgs; [
        feh
        maim
        slop
        xdotool
        xclip
      ];

      services.xserver = {
        enable = true;
        autoRepeatDelay = 300;
        autoRepeatInterval = 20;
        excludePackages = with pkgs; [xterm];
        displayManager = {
          sessionCommands = ''
            if [ -f ~/.fehbg ]; then
              sh ~/.fehbg
            fi
            ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr
          '';
        };
        windowManager.dwm = {
          enable = true;
          package = pkgs.dwm.override {
            conf = ./config.h;
            patches = map pkgs.fetchpatch [
              {
                url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.4.diff";
                sha256 = "sha256-+OXRqnlVeCP2Ihco+J7s5BQPpwFyRRf8lnVsN7rm+Cc=";
              }
              {
                url = "https://dwm.suckless.org/patches/attachaside/dwm-attachaside-6.6.diff";
                sha256 = "sha256-xxRnyk0/go9HJHrrGuGlWmDXKh/MmNRLClpk1/dY9gg=";
              }
              {
                url = "https://dwm.suckless.org/patches/actualfullscreen/dwm-actualfullscreen-20211013-cb3f58a.diff";
                sha256 = "sha256-vsTuudJCy7Zo1wdwpI/nY7Zu1txXx90QoDfJLmfDUH8=";
              }
            ];
          };
        };
      };
    }
    else {}
  );
}
