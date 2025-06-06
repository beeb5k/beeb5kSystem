{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    git
    file
    binutils
    eza
    bat
    ripgrep
    fzf
    libnotify
    satty
    wl-clipboard
    pavucontrol
    brightnessctl
  ];
}
