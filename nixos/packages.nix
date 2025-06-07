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
    wl-clipboard
    pavucontrol
    brightnessctl
  ];
}
