{inputs, ...}: let
  lib = inputs.nixpkgs.lib;
  mkMods = homeManager: let
    args = {
      inherit inputs homeManager;
    };
  in {
    mango = import ./mango args;
    dwm = import ./dwm args;
    specialisation = import ./specialisations args;
  };
in {
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.unspecified;
  };

  config = {
    flake.nixosModules = mkMods false;
    flake.homeModules = mkMods true;
  };
}
