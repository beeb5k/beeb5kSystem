{
  pkgs,
  quickshell,
  config,
  ...
}:
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
    grimblast
    fastfetchMinimal
    vesktop
    matugen
    rustc
    rustfmt
    clippy
    cargo
    fd
    onefetch
    gimp
    (pkgs.obsidian.overrideAttrs (oldAttrs: rec {
      desktopItem = oldAttrs.desktopItem.override {
        exec = "obsidian --ozone-platform=wayland %u";
      };
      installPhase =
        builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ]
          oldAttrs.installPhase;
    }))
    anyrun
    jdk
    skim
    quickshell.packages.${pkgs.system}.default
  ];
}
