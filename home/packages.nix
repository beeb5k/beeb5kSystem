{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    imv
    stylua
    nixfmt-rfc-style
    llvmPackages_19.libcxxClang
    pokeget-rs
    zed-editor-fhs
    lua
    hyprshot
    fastfetchMinimal
    vesktop
    nil
    nixd
    matugen
    rustc
    rustfmt
    clippy
    cargo
    pywalfox-native
  ];
}
