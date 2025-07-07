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
    jdk
    jetbrains.idea-ultimate
    sqlite
    (pkgs.obsidian.overrideAttrs (oldAttrs: rec {
      desktopItem = oldAttrs.desktopItem.override {
        exec = "obsidian --ozone-platform=wayland %u";
      };
      installPhase =
        builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ]
          oldAttrs.installPhase;
    }))
    anyrun
    skim
    # quickshell.packages.${pkgs.system}.default
  ];
}
