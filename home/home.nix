{ pkgs, lib, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
    ./packages.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";
  services.swww.enable = true;
  home.stateVersion = "25.11";

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

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.size = 16;
    dotIcons.enable = true;
    hyprcursor.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraCss = ''
      @import "colors.css";
    '';

    gtk4.extraCss = ''
      @import "colors.css";
    '';
  };

  # qt.enable = true;
  # qt.platformTheme.name = "qtct";
  # qt.style.name = "kvantum";

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    BROWSER = "zen";
    JDTLS_WORKSPACE = "$HOME/.local/share/jdtls/workspace";
    JDTLS_CACHE = "$HOME/.cache/jdtls";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf" = {
      enable = true;
      text = ''
        [Appearance]
        color_scheme_path=/home/beeb5k/.config/qt5ct/colors/matugen.conf
        custom_palette=true
        icon_theme=OneUI
        standard_dialogs=default
        style=kvantum

        [Fonts]
        fixed="JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
        general="Rubik,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid
      '';
    };

    "qt6ct/qt6ct.conf" = {
      enable = true;
      text = ''
        [Appearance]
        color_scheme_path=/home/beeb5k/.config/qt6ct/colors/matugen.conf
        custom_palette=true
        icon_theme=OneUI
        standard_dialogs=default
        style=kvantum

        [Fonts]
        fixed="JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
        general="Rubik,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\as\0\0\x4\x3)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid
      '';
    };
    "Kvantum/kvantum.kvconfig" = {
      enable = true;
      text = ''
        [General]
        theme=matugen
      '';
    };
  };

  programs.home-manager.enable = true;
}
