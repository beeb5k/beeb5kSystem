{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
<<<<<<< HEAD
<<<<<<< HEAD
    beeb5kvim.url = "git+https://codeberg.org/beeb5k/beeb5kvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dwm.url = "git+https://codeberg.org/beeb5k/dwm";
    # dwm.url = "git+file:/home/bee/Projects/dwm";
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
=======
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
=======
>>>>>>> cd08309 (Homecoming)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
<<<<<<< HEAD
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
=======
    mydwm = {
      url = "git+https://codeberg.org/brustybee/mydwm";
      # url = "git+file:/home/bee/mydwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
<<<<<<< HEAD
      url = "github:AvengeMedia/DankMaterialShell/stable";
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
=======
      url = "github:AvengeMedia/DankMaterialShell";
>>>>>>> cd08309 (Homecoming)
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
<<<<<<< HEAD
      systems = [ "x86_64-linux" ];
      imports = [ (inputs.nixpkgs.lib.modules.importApply ./common inputs) ];

      flake =
        let
          systemState = "25.11";
          mkSystem = import ./lib/mkSystem.nix {
            inherit inputs;
            inherit (inputs) nixpkgs;
          };
          mkHome = import ./lib/mkHome.nix {
            inherit inputs;
            inherit (inputs) home-manager nixpkgs;
          };
        in
        {
          nixosConfigurations.lixos = mkSystem {
            inherit systemState;
            system = "x86_64-linux";
            hostname = "lixos";
            user = "bee";
          };

          # homeConfigurations."beeb5k" = mkHome {
          #   inherit systemState;
          #   system = "x86_64-linux";
          #   username = "beeb5k";
          # };
        };
=======
      systems = inputs.nixpkgs.lib.platforms.all;
      imports = [
        (inputs.nixpkgs.lib.modules.importApply ./common inputs)
      ];

      flake =
        let
          inherit (inputs) nixpkgs home-manager;

          builders = import ./lib/mkFlakeOutputs.nix { inherit nixpkgs home-manager inputs; };
          inherit (builders) mkSystemWithHM mkSystemWithHMasModule mkSystem;

          merge = builtins.foldl' nixpkgs.lib.recursiveUpdate { };
        in
        merge [
          (mkSystemWithHM {
            user = "bee";
            hostname = "nixios";
            system = "x86_64-linux";
            systemState = "25.11";
          })
        ];
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
    };
}
