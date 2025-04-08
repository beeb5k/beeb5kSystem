{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    nitch
    swaybg
    base16-schemes
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
  ];
}
