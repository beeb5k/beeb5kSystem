inputs:
{ lib, ... }:
{
  imports = [
<<<<<<< HEAD
    (lib.modules.importApply ./modules { inherit inputs; })
  ];
=======
    (lib.modules.importApply ./overlays { inherit inputs; })
    # (inputs.nixpkgs.lib.modules.importApply ./overlays { inherit inputs; })
    (lib.modules.importApply ./modules { inherit inputs; })
  ];

>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
  flake.templates = import ./templates inputs;
  flake.homeModules.programs = import ./programs;
}
