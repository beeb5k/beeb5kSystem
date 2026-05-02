lib: dir:
let
  nodes = builtins.readDir dir;

  shouldImport =
    name: type:
    let
      path = dir + "/${name}";
    in
    (type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name)
    || (type == "directory" && builtins.pathExists (path + "/default.nix"));

  validNodes = lib.filterAttrs shouldImport nodes;
in
map (name: dir + "/${name}") (builtins.attrNames validNodes)
