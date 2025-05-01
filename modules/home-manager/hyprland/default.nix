{
  imports = [
    ./animations.nix
    ./keybindings.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",1920x1080@120,auto,1.0"
      ];

      # My Programs
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "pcmanfm";
      "$menu" = "wofi --show drun";

      # Environment Variables
      env = [
        "XCURSOR_SIZE,16"
        "HYPRCURSOR_SIZE,16"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settings
      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
          new_optimizations = true;
        };
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Miscellaneous settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # Input settings
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        repeat_delay = 300;
        repeat_rate = 70;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Gestures
      gestures = {
        workspace_swipe = false;
      };

      # Per-device input config
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      # Window and workspace rules
      windowrulev2 = [
        "suppressevent maximize,class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # Uncomment if you want to use workspace rules for smart gaps
      # workspace = [
      #   "w[tv1],gapsout:0,gapsin:0"
      #   "f[1],gapsout:0,gapsin:0"
      # ];
      # windowrulev2 = [
      #   "bordersize 0,floating:0,onworkspace:w[tv1]"
      #   "rounding 0,floating:0,onworkspace:w[tv1]"
      #   "bordersize 0,floating:0,onworkspace:f[1]"
      #   "rounding 0,floating:0,onworkspace:f[1]"
      # ];
    };
  };
}
