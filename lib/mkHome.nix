{
  home-manager,
  inputs,
  nixpkgs,
  ...
}:
{
  username,
  systemState,
  system,
}:
let
  homeConfig = import ../users/${username} { inherit username systemState; };
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = { inherit inputs; };

  modules = [
    homeConfig
    inputs.beeb5kvim.homeModules.default
  ];
}
