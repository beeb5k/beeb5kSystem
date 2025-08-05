{
  pkgs,
  lib,
  ...
}:
{
  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";
  services.swww.enable = true;

  Neovim = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      lib.mkForce [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

    # config = {
    #   common = {
    #     "org.freedesktop.impl.portal.FileChooser" = "kde";
    #   };
    #   Hyprland = {
    #     "org.freedesktop.impl.portal.FileChooser" = "kde";
    #   };
    # };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    BROWSER = "zen";
    JDTLS_WORKSPACE = "$HOME/.local/share/jdtls/workspace";
    JDTLS_CACHE = "$HOME/.cache/jdtls";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
