{ pkgs, ... }:
let
  screenshot = import ./screenshot.nix { inherit pkgs; };
  pp = import ./powerprofle.nix { inherit pkgs; };
  audio = import ./audio.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    screenshot
    pp
    audio
  ];
}
