inputs:
{ lib, ... }:
{
  imports = [
    (lib.modules.importApply ./overlays { inherit inputs; })
    # (inputs.nixpkgs.lib.modules.importApply ./overlays { inherit inputs; })
    (lib.modules.importApply ./modules { inherit inputs; })
  ];

  flake.templates = import ./templates inputs;
  flake.homeModules.programs = import ./programs;
}
