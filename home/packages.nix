{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nitch
    swaybg
    mpv
    imv
    stylua
    nixfmt-rfc-style
    llvmPackages_19.libcxxClang
    pokeget-rs
    vscode-fhs
    go
    lua
    rustc
    rustfmt
    clippy
    cargo
    vesktop
    hyprshot
    fastfetchMinimal
  ];
}
