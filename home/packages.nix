{
  pkgs,
  inputs,
  config,
  ...
}:
let
  system = config.system.platform;
in
{
  home.packages = with pkgs; [
    mpv
    imv
    stylua
    nixfmt-rfc-style
    # llvmPackages_19.libcxxClang
    pokeget-rs
    zed-editor-fhs
    lua
    hyprshot
    fastfetchMinimal
    vesktop
    nil
    nixd
    # (vesktop.overrideAttrs (old: {
    #   postInstall =
    #     (old.postInstall or "")
    #     + ''
    #       substituteInPlace $out/share/applications/vesktop.desktop \
    #         --replace 'Exec=vesktop %U' 'Exec=vesktop --ozone-platform=wayland %U'
    #     '';
    # }))
  ];
}
