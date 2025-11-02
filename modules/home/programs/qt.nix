{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    qt6.qtdeclarative
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
}
