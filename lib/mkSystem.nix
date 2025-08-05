{
  pkgs,
  lib,
  ...
}:
{
  system,
  hostname,
  user,
}:
let
  hostConfig = import ../hosts/${hostname} { inherit user; };
in
lib.nixosSystem rec {
  inherit system;

  modules = [
    hostConfig
  ];
}
