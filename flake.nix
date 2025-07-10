{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    beeb5kvim.url = "git+file:/home/beeb5k/beeb5kvim";
    # beeb5kvim.url = "git+https://codeberg.org/beeb5k/beeb5kVim.git";
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
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
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
