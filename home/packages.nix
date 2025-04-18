{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    nitch
    swaybg
    ffmpeg-full
    mpv
    imv
    fastfetch
    stylua
    nixfmt-rfc-style
    cmatrix
    pulseaudio
    ristate
    pkg-config
    wayland-scanner
    jq
    python314
    llvmPackages_19.libcxxClang
    firefox
  ];
}
