{
  nixConfig = {
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    beeb5kvim.url = "github:beeb5k/beeb5kvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [(inputs.nixpkgs.lib.modules.importApply ./common inputs)];

      flake = let
        systemState = "25.11";
        mkSystem = import ./lib/mkSystem.nix {
          inherit inputs;
          inherit (inputs) nixpkgs;
        };
        mkHome = import ./lib/mkHome.nix {
          inherit inputs;
          inherit (inputs) home-manager nixpkgs;
        };
      in {
        nixosConfigurations.bixos = mkSystem {
          inherit systemState;
          system = "x86_64-linux";
          hostname = "bixos";
          user = "beeb5k";
        };

        # homeConfigurations."beeb5k" = mkHome {
        #   inherit systemState;
        #   system = "x86_64-linux";
        #   username = "beeb5k";
        # };
      };
    };
}
