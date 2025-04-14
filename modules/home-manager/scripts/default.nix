{ pkgs, ... }:
let
  screenshot = import ./screenshot.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    screenshot
  ];
}
