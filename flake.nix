{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    beeb5kvim.url = "git+https://codeberg.org/beeb5k/beeb5kVim.git";
    beeb5kvim.flake = true;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-lzextras.url = "github:BirdeeHub/lzextras";
    plugins-lzextras.flake = false;
    plugins-lze.url = "github:BirdeeHub/lze";
    plugins-lze.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      beeb5kvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.dixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          beeb5kvim.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.beeb5k = ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
