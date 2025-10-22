{
  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;
    systemd.enable = false;
    xwayland.enable = true;
    systemd.enableXdgAutostart = false;

    extraConfig = ''
      general {
        col.active_border = $tertiary_fixed_dim
        col.inactive_border = $outline
      }
    '';

    settings = {
      monitor = [ ",1920x1080@120,auto,1.0" ];
      source = [ "colors.conf" ];

      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$browser" = "librewolf";
      "$menu" = "fuzzel";

      exec-once = [
        # "foot --server"
      ];

      env = [
        # "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        # "HYPRCURSOR_SIZE,16"
        # "XCURSOR_THEME,Bibata-Modern-Classic"
        # "XCURSOR_SIZE,16"
        # "XDG_MENU_PREFIX, plasma-"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        follow_mouse = 1;
        kb_layout = "us";
        repeat_delay = 300;
        repeat_rate = 50;
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
        # col.active_border = "$outline";
        # col.inactive_border = "$outline";
      };

      dwindle = {
        smart_split = false;
        smart_resizing = false;
        preserve_split = true;
        pseudotile = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = false;
          xray = true;
          special = false; # omg this guy stinks.
          new_optimizations = true;
          size = 14;
          passes = 3;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          input_methods = false;
          input_methods_ignorealpha = 0.8;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          range = 20;
          offset = "0 2";
          render_power = 3;
          color = "$shadow";
        };

        # Window Opacities
        # active_opacity = 0.87;
        # inactive_opacity = 0.87;
        fullscreen_opacity = 1;

        # Dim
        dim_inactive = true;
        dim_strength = 0.06;
        dim_special = 0.3;
      };

      misc = {
        vfr = true;
        vrr = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_splash_rendering = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|alacritty|Alacritty|com.mitchellh.ghostty|)";

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;
        initial_workspace_tracking = false;
        focus_on_activate = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      binds = {
        scroll_event_delay = 0;
        hide_special_on_workspace_change = true;
      };

      render = {
        direct_scanout = 1;
        new_render_scheduling = true;
      };

      cursor = {
        zoom_factor = 1;
        zoom_rigid = false;
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      master.new_status = "master";
    };
  };
}
