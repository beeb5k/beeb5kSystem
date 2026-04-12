{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
  mkMods =
    homeManager:
    let
      args = {
<<<<<<< HEAD
        inherit inputs homeManager;
      };
    in
    {
      mango = import ./mango args;
      hypr = import ./hypr args;
      dwm = import ./dwm args;
      scripts = import ./scripts args;
=======
        moduleNameSpace = "beeMods";
        inherit inputs homeManager;
      };
      modules = {
        mango = import ./mango args;
        hypr = import ./hyprland args;
        dwm = import ./dwm args;
        terminal = import ./terminal args;
        beevim = import ./beevim args;
        matugen = import ./matugen args;
      };
    in
    modules
    // {
      beeMods = {
        imports = lib.attrValues modules;
      };
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
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
