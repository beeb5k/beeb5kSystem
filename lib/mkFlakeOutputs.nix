# lib/mkFlakeOutputs.nix
#
# Single file exposing all system/home builder functions.
# Partially apply once in flake.nix with flake-level deps,
# then call whichever helper you need.
{
  nixpkgs,
  home-manager,
  inputs,
}:
let
  importer = import ./importer.nix nixpkgs.lib;

  # Shared: build a NixOS system derivation
  buildSystem =
    {
      system,
      hostname,
      user,
      systemState,
    }:
    let
      hostConfig = import ../hosts/${hostname} { inherit user systemState hostname; };
    in
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          inputs
          user
          hostname
          systemState
          importer
          ;
      };
      modules = [
        hostConfig
        { nixpkgs.overlays = builtins.attrValues (inputs.self.overlays or { }); }
      ];
    };

  # Shared: build a standalone Home Manager derivation
  buildHome =
    {
      system,
      user,
      systemState,
    }:
    let
      homeConfig = import ../users/${user} { inherit user systemState; };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = builtins.attrValues (inputs.self.overlays or { });
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs importer; };
      modules = [
        homeConfig
        # inputs.beeb5kvim.homeModules.default
      ];
    };
in
{
  # NixOS + standalone Home Manager (two separate outputs)
  mkSystemWithHM =
    {
      system,
      hostname,
      user,
      systemState,
    }:
    {
      nixosConfigurations.${hostname} = buildSystem {
        inherit
          system
          hostname
          user
          systemState
          ;
      };
      homeConfigurations.${user} = buildHome { inherit system user systemState; };
    };

  # NixOS with Home Manager as a NixOS module (single output, HM is baked in)
  mkSystemWithHMasModule =
    {
      system,
      hostname,
      user,
      systemState,
    }:
    let
      hostConfig = import ../hosts/${hostname} { inherit user systemState hostname; };
      homeConfig = import ../users/${user} { inherit user systemState; };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            inputs
            user
            hostname
            systemState
            importer
            ;
        };
        modules = [
          hostConfig
          home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
          { nixpkgs.overlays = builtins.attrValues (inputs.self.overlays or { }); }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs importer; };
            home-manager.users.${user} = homeConfig;
          }
        ];
      };
    };

  # NixOS only, no Home Manager at all
  mkSystem =
    {
      system,
      hostname,
      user,
      systemState,
    }:
    {
      nixosConfigurations.${hostname} = buildSystem {
        inherit
          system
          hostname
          user
          systemState
          ;
      };
    };
}
