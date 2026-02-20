{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      pname = "hello-c";
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation {
            inherit pname;
            version = "0.1.0";
            src = self;

            # The zig hook handles the build AND the install automatically
            nativeBuildInputs = [ pkgs.zig.hook ];
            doCheck = true;
          };
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.zig
              pkgs.zls
              pkgs.clang-tools
            ];
          };
        }
      );
    };
}
