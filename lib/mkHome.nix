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
  pkgs = nixpkgs.legacyPackages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = { inherit inputs; };

  modules = [
    homeConfig
    inputs.beeb5kvim.homeModules.default
  ];
}
