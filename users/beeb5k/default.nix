{
  systemState,
  user,
}: {
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.beeb5kvim.homeModules.default
    inputs.self.homeModules.bspwm
    inputs.self.homeModules.river
    inputs.self.homeModules.programs
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  terminal = {
    emulator = "foot"; # alacritty, foot, ghostty.
    font = {
      family = "Lilex Nerd Font";
      size = 12.0;
      bright_color_is_bold = false;
      ligatures = false; # only supported by ghostty
    };
    window = {
      padding-x = 10;
      padding-y = 10;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      # Note: Keys with hyphens usually need quotes in Nix
      "button-layout" = "";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

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

    signing = {
      key = "1D8222FA8B7E93A6";
      signByDefault = true;
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

  bspwm.enable = false;
  river.enable = true;

  xresources.properties = {
    "Xft.dpi" = 96; # Set to 96 for standard 100% scaling
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };

  programs.mangohud = {
    enable = true;
    settings = {
      fps_metrics = ["1"];
      # avg = Average FPS
      # 1   = 1% Lows (Stutter indicator)
      # 0.1 = 0.1% Lows (Worst case stutters)

      # --- 2. Hardware Names (Instead of generic labels) ---
      cpu_name = true; # Shows "AMD Ryzen 5 5600X"

      frame_timing = true; # The frametime graph (green line)
      cpu_stats = true; # CPU usage graph
      gpu_stats = true; # GPU usage graph
      ram = true; # System RAM usage
      vram = true; # Video RAM usage
      fps = true; # FPS number
      frametime = true; # Frametime number (ms)

      # --- Hardware Info & Names (Fixes "GPU0/GPU1") ---
      gpu_name = true; # Shows "Radeon RX 6700 XT" instead of "GPU"
      cpu_temp = true; # CPU Temperature
      gpu_temp = true; # GPU Temperature
      cpu_power = true; # CPU Power Draw (Watts)
      gpu_power = true; # GPU Power Draw (Watts)

      # --- Visuals ---
      font_size = 24;
      position = "top-left"; # top-left, top-right, bottom-left, etc.
      round_corners = 10;
      background_alpha = "0.4"; # Semi-transparent background

      # --- Interaction ---
      toggle_hud = "Shift_R+F12"; # Right Shift + F12 to hide/show
      toggle_logging = "Shift_L+F2"; # Left Shift + F2 to start logging benchmarks
    };
  };

  home.sessionVariables = {};

  home.packages = with pkgs; [
    vscode
    gimp3-with-plugins
    opencode
    obsidian
    matugen
    pywal16
    imagemagick
    pavucontrol
    brightnessctl
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
