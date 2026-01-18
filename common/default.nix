inputs: {lib, ...}: {
  imports = [
    (lib.modules.importApply ./modules {inherit inputs;})
  ];
  flake.homeModules.programs = import ./programs;
}
