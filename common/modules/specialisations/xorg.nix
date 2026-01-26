{
  pkgs,
  lib,
  user,
  ...
}: {
  specialisation = {
    x11.configuration = {
      mango.enable = lib.mkForce false;
      bspwm.enable = lib.mkForce true;
      home-manager.users.${user} = {
        bspwm.enable = lib.mkForce true;
        mango.enable = lib.mkForce false;
      };
    };
  };
}
