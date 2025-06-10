{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = false;

    # systemd.enableXdgAutostart = true;
    # systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "pcmanfm";
      "$menu" = "wofi --show drun";

      # exec-once = [
      #   "ashell"
      #   "walker --gapplication-service"
      # ];

      # env = [
      #   "TERMINAL,foot"
      #   "EDITOR,nvim"
      #   "LIBVA_DRIVER_NAME,nvidia"
      #   "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      # ];

      monitor = [ ",1920x1080@120,auto,1.0" ];

      input = {
        follow_mouse = 1;
        kb_layout = "us";
        repeat_delay = 300;
        repeat_rate = 70;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      general = {
        layout = "dwindle";
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;

        resize_on_border = true;
        no_focus_fallback = true;

        #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
        allow_tearing = true; # This just allows the `immediate` window rule to work
      };

      dwindle = {
        smart_split = false;
        smart_resizing = false;
        preserve_split = true;
        pseudotile = true;
      };

      decoration = {
        rounding = 15;
        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 14;
          passes = 5;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };
        shadow = {
          enabled = true;
          ignore_window = true;
          range = 20;
          offset = "0 2";
          render_power = 4;
          color = "rgba(0000002A)";
        };

        # Window Opacities
        # active_opacity = 1;
        # inactive_opacity = 1;
        # fullscreen_opacity = 1;

        # Shader
        # screen_shader = ~/.config/hypr/shaders/nothing.frag
        # screen_shader = ~/.config/hypr/shaders/vibrance.frag

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };

      gestures.workspace_swipe = false;

      misc = {
        # vfr = 1;
        #  vrr = 1;
        #  disable_hyprland_logo = true;
        #  disable_splash_rendering = true;
        #  force_default_wallpaper = -1;
        vfr = 1;
        vrr = 1;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;

        initial_workspace_tracking = false;
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      master.new_status = "master";
    };
    extraConfig = '''';
  };
}
