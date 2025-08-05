{
  description = "Flake for nix config.";

  inputs = {
    beeb5kvim.url = "github:beeb5k/beeb5kvim";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # beeb5kvim.url = "git+file:/home/beeb5k/beeb5kvim";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      systemState = "25.05";
      mkSystem = import ./lib/mkSystem.nix {
        inherit nixpkgs inputs;
      };
      mkHome = import ./lib/mkHome.nix {
        inherit home-manager nixpkgs inputs;
      };
    in
    {
      nixosConfigurations.bixos = mkSystem {
        inherit systemState;
        system = "x86_64-linux";
        hostname = "bixos";
        user = "beeb5k";
      };

      homeConfigurations."beeb5k" = mkHome {
        inherit systemState;
        system = "x86_64-linux";
        username = "beeb5k";
      };
    };
}
