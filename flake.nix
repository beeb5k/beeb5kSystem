{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-lzextras.url = "github:BirdeeHub/lzextras";
    plugins-lzextras.flake = false;
    plugins-lze.url = "github:BirdeeHub/lze";
    plugins-lze.flake = false;
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
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
          stylix.homeManagerModules.stylix
          ./home/home.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
