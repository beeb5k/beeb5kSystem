{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    mpv
    imv
    stylua
    nixfmt-rfc-style
    # llvmPackages_19.libcxxClang
    pokeget-rs
    vscode-fhs
    lua
    vesktop
    hyprshot
    fastfetchMinimal
  ];
}
