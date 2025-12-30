{
  description = "Flake for nix config.";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    beeb5kvim.url = "github:beeb5k/beeb5kvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    miku-cursor-src.url = "github:supermariofps/hatsune-miku-windows-linux-cursors";
    miku-cursor-src.flake = false;
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systemState = "25.05";
    mkSystem = import ./lib/mkSystem.nix {
      inherit nixpkgs inputs;
    };
    mkHome = import ./lib/mkHome.nix {
      inherit home-manager nixpkgs inputs;
    };
  in {
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
