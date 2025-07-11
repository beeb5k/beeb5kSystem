{ pkgs, ... }:
let
  changetermcolor = import ./terminalColor.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    changetermcolor
  ];
}
