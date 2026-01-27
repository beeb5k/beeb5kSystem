{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      credential.helper = "store";
      user = {
        email = "112796674+beeb5k@users.noreply.github.com";
        name = "beeb5k";
      };
    };
  };

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
  };

  xresources.properties = {
    "Xft.dpi" = 96;
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/Downloads"
      "file://${config.home.homeDirectory}/Pictures"
      "file://${config.home.homeDirectory}/Documents"
      "file://${config.home.homeDirectory}/Videos"
      "file://${config.home.homeDirectory}/beeb5kSystem Config"
    ];
    gtk3.extraCss = ''
      @import url("colors.css");
    '';
    gtk4.extraCss = ''
      @import url("colors.css");
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = "";
    };
  };

  xdg.dataFile."keyrings/default".text = "login";
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
