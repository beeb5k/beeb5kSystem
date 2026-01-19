{lib, ...}: let
  files = builtins.readDir ./.;
  filterValidFiles = name: type:
    type
    == "regular"
    && name != "default.nix"
    && lib.hasSuffix ".nix" name;

  validFiles = lib.filterAttrs filterValidFiles files;

  importPaths = map (name: ./. + "/${name}") (builtins.attrNames validFiles);
in {
  imports = importPaths;
}
