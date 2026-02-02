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
      environment.sessionVariables = lib.mkForce {};
      home-manager.users.beeb5k = {
        mango.enable = lib.mkForce false;
      };
    };
  };
}
