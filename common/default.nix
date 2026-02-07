inputs: {lib, ...}: {
  imports = [
    (lib.modules.importApply ./modules {inherit inputs;})
  ];
  flake.templates = import ./templates inputs;
  flake.homeModules.programs = import ./programs;
}
