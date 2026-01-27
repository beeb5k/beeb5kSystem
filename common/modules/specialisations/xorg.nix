{
  pkgs,
  lib,
  user,
  ...
}: {
  specialisation = {
    xorg.configuration = {
      mango.enable = lib.mkForce false;
      dwm.enable = lib.mkForce true;
      home-manager.users.beeb5k = {
        mango.enable = lib.mkForce false;
      };
    };
  };
}
