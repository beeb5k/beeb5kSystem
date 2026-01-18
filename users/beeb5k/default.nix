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
    inputs.self.homeModules.programs
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  terminal = {
    emulator = "alacritty"; # alacritty, foot, ghostty.
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

  Neovim = {
    enable = true;
    packageDefinitions.replace =
      builtins.mapAttrs (n: _: {pkgs, ...}: {
        categories = {
          go = false;
          clang = true;
          misc = true;
        };
        extra = {
          pluginChoice = "fancy"; # fancy , fast , normal
        };
      })
      inputs.beeb5kvim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
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
    gtk3.extraCss = ''
      @import url("colors.css");
    '';
    gtk4.extraCss = ''
      @import url("colors.css");
    '';
  };

  bspwm.enable = true;

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

  services.picom = {
    enable = true;

    backend = "egl";
    vSync = true;

    settings = {
      use-damage = true;
      unredir-if-possible = true;
      detect-transient = true;
      detect-client-opacity = true;

      vsync-use-glfinish = false;
      dbe = false;

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;

      shadow = false;
      fade = false;
      blur-method = "none";
      animations = false;

      inactive-opacity = 1.0;
      active-opacity = 1.0;
      frame-opacity = 1.0;

      detect-rounded-corners = true;
      resize-damage = 1;
    };
  };

  home.packages = with pkgs; [
    vscode
    gimp3-with-plugins
    opencode
    obsidian
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
