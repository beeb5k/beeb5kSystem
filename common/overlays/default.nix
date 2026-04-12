{ inputs, ... }:
{
  flake.overlays = {
    ioskeleyMono = import ./ioskeleyMono.nix;
    iosevkaInput = import ./ioskeleyInput.nix;
    qt6ct = import ./qt6ct.nix;
  };
}
