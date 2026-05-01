{
  homeManager,
  inputs,
  moduleNameSpace,
  ...
}:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.${moduleNameSpace}.emacs;
in
{
  imports = lib.optionals homeManager [
    inputs.nix-doom-emacs-unstraightened.homeModule
  ];

  options.${moduleNameSpace}.emacs = {
    enable = lib.mkEnableOption "Enable emacs";
  };

  config = lib.mkIf cfg.enable (
    lib.optionalAttrs homeManager {
      programs.doom-emacs = {
        enable = true;
        doomDir = ./doom; # or e.g. `./doom.d` for a local configuration
      };
    }
  );
}
