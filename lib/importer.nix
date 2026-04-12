<<<<<<< HEAD
# ./lib/importer.nix
=======
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
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
