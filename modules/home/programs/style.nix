{
  pkgs,
  inputs,
  ...
}: let
  mikuCursor = pkgs.stdenv.mkDerivation {
    pname = "miku-cursor";
    version = "1.0";
    src = inputs.miku-cursor-src;
    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src/miku-cursor-linux $out/share/icons/miku-cursor
    '';
  };
in {
  home.pointerCursor = {
    size = 16;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.size = 16;
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    # name = "miku-cursor";
    # package = mikuCursor;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
