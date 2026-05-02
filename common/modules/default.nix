{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
  mkMods =
    homeManager:
    let
      args = {
        moduleNameSpace = "beeMods";
        inherit inputs homeManager;
      };
      modules = {
        windowManagers = import ./window_managers args;
        terminal = import ./terminal args;
        matugen = import ./matugen args;
        emacs = import ./emacs args;
      };
    in
    modules
    // {
      beeMods = {
        imports = lib.attrValues modules;
      };
    };
in
{
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.unspecified;
  };

  config = {
    flake.nixosModules = mkMods false;
    flake.homeModules = mkMods true;
  };
}
