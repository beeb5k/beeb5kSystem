{
  pkgs,
  lib,
  ...
}: {
  specialisation = {
    xorg.configuration = {
      mango.enable = lib.mkForce false;
      bspwm.enable = lib.mkForce true;

      home-manager.users.beeb5k = {
        bspwm.enable = lib.mkForce true;
        mango.enable = lib.mkForce false;
        terminal = {
          emulator = {
            foot = lib.mkForce false;
            alacritty = lib.mkForce true;
            ghostty = lib.mkForce false;
          };
        };
      };
    };
  };
}
