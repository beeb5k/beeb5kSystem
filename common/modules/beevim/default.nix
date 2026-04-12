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
  cfg = config.${moduleNameSpace}.beeVim;
in
{
  imports = lib.optionals homeManager [
    inputs.beeVim.homeModules.default
  ];

  options.${moduleNameSpace}.beeVim = {
    enable = lib.mkEnableOption "Enable neovim config";
  };

  config = lib.mkIf cfg.enable (
    lib.optionalAttrs homeManager {
      beeVim = {
        enable = true;
        packageDefinitions.replace = builtins.mapAttrs (
          n: _:
          { pkgs, ... }:
          {
            settings = {
              neovim-unwrapped = pkgs.neovim-unwrapped;
            };
            categories = {
              clang = false;
              markdown = false;
            };
          }
        ) inputs.beeVim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
      };
    }
  );
}
