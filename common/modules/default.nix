{inputs, ...}: let
  lib = inputs.nixpkgs.lib;
  mkMods = homeManager: let
    args = {
      inherit inputs homeManager;
    };
  in {
    bspwm = import ./bspwm args;
  };
in {
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.unspecified;
  };

  # <--- 3. Wrap your existing logic in 'config'
  config = {
    flake.nixosModules = mkMods false;
    flake.homeModules = mkMods true;
  };
}

