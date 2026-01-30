{
  nixpkgs,
  inputs,
  ...
}: {
  system,
  hostname,
  user,
  systemState,
}: let
  hostConfig = import ../hosts/${hostname} {inherit user systemState hostname;};
  importer = import ./importer.nix nixpkgs.lib;
in
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user hostname systemState importer;
    };

    modules = [
      hostConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ../users/${user} {inherit user systemState;};
        home-manager.extraSpecialArgs = {inherit inputs importer;};
      }
    ];
  }
