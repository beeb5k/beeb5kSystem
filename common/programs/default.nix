{lib, ...}: let
  nodes = builtins.readDir ./.;

  shouldImport = name: type: let
    path = ./. + "/${name}";
  in
    (type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name)
    || (type == "directory" && builtins.pathExists (path + "/default.nix"));

  validNodes = lib.filterAttrs shouldImport nodes;
in {
  imports = map (name: ./. + "/${name}") (builtins.attrNames validNodes);
}
