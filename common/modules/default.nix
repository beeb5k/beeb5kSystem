{inputs, ...}: let
  lib = inputs.nixpkgs.lib;
  mkMods = homeManager: let
    args = {
      inherit inputs homeManager;
    };
  in {
    bspwm = import ./bspwm args;
    river = import ./river args;
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
