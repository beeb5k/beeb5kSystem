{
  pkgs,
  config,
  ...
}:
let
  mikuCursor = pkgs.stdenv.mkDerivation {
    pname = "miku-cursor";
    version = "1.0";
    src = pkgs.fetchgit {
      url = "https://github.com/supermariofps/hatsune-miku-windows-linux-cursors.git";
      rev = "471ff88";
      hash = "sha256-HCHo4GwWLvjjnKWNiHb156Z+NQqliqLX1T1qNxMEMfE=";
    };
    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src/miku-cursor-linux $out/share/icons/miku-cursor
    '';
  };
in
{
  programs.git = {
    enable = true;
    package = pkgs.git.override { withLibsecret = true; };
    settings = {
      user = {
        name = "bee";
        email = "beebeeb5k@gmail.com";
        signingkey = "42177A22EA630575";
      };
      init.defaultBranch = "main";
      credential.helper = "libsecret";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };

  home.pointerCursor = {
    size = 36;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.size = 16;
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = "miku-cursor";
    package = mikuCursor;
  };

  dconf.settings = {
    # "org/gnome/desktop/interface" = {
    #   color-scheme = "prefer-dark";
    # };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
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
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Videos"
        "file://${config.home.homeDirectory}/Music"
      ];
      extraConfig = {
        gtk-cursor-blink = false;
        gtk-decoration-layout = ":";
      };
      extraCss = ''
        @import url("noctalia.css");
      '';
    };

    gtk4 = {
      theme = config.gtk.theme;
      extraConfig = {
        gtk-cursor-blink = false;
        gtk-decoration-layout = ":";
      };
      extraCss = ''
        @import url("noctalia.css");
      '';
    };
  };

  xdg.dataFile."keyrings/default".text = "login";
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };

  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped.override {
      javascriptSupport = false;
    };
    config = {
      # hwdec = "nvdec";
      hwdec = "auto";
      profile = "high-quality";
      save-position-on-quit = "yes";
      sub-font = "IosevkaInput Heavy";
      sub-font-size = 25;
      sub-shadow-offset = 0;
      sub-border-size = 1;
      sub-ass-override = "force";
    };
  };

  home.packages = with pkgs; [
    nautilus
    imv
    gnome-calculator
    accountsservice
    equibop
    fastfetch
    clang
    neovim
    gpu-screen-recorder
  ];
}
