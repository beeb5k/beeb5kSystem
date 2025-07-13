{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    mpv
    imv
    llvmPackages_19.libcxxClang
    pokeget-rs
    grimblast
    fastfetchMinimal
    vesktop
    matugen
    fd
    onefetch
    gimp
    jdk
    vscode
    rustup
    (pkgs.obsidian.overrideAttrs (oldAttrs: rec {
      desktopItem = oldAttrs.desktopItem.override {
        exec = "obsidian --ozone-platform=wayland %u";
      };
      installPhase =
        builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ]
          oldAttrs.installPhase;
    }))
    anyrun
    inputs.quickshell.packages.${pkgs.system}.default
  ];
}
