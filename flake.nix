{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # beeb5kvim.url = "git+https://codeberg.org/beeb5k/beeb5kVim.git";
    beeb5kvim.url = "git+file:/home/beeb5k/beeb5kVim";
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
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.dixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };

      homeConfigurations."beeb5k" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
          beeb5kvim.homeModules.default
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
