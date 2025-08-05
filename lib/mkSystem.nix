{
  nixpkgs,
  inputs,
  ...
}:
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
  specialArgs = { inherit inputs; };

  modules = [
    hostConfig
  ];
}
