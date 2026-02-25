{
  lib,
  config,
  pkgs,
  ...
}:
let
  hypr = config.hyprland;
in
{
  wayland.windowManager.hyprland = {
    enable = hypr.enable;
    package = pkgs.hyprland;
    sourceFirst = true;
    systemd.enable = false;
    xwayland.enable = hypr.xwayland;
    systemd.enableXdgAutostart = false;

    settings = {
      monitor = [ ",1920x1080@120,auto,1.0" ];
      source = [ "colors.conf" ];

      "$mainMod" = "SUPER";
      "$terminal" = config.terminal.emulator.default;
      "$fileManager" = "nautilus";
      "$browser" = "zen";

      exec-once = [
        "dbus-update-activation-environment --all"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "gnome-keyring-daemon --start --components=secrets"
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
        layout = hypr.layout;
        gaps_in = 4;
        gaps_out = 4;
        gaps_workspaces = 30;
        border_size = 2;

        resize_on_border = true;
        no_focus_fallback = true;

        #focus_to_other_workspaces = true
        allow_tearing = true;
        "col.active_border" = "$_tertiary_fixed_dim";
        "col.inactive_border" = "$_outline";
      };

      master = {
        allow_small_split = true;
        new_status = "master";
        new_on_top = true;
      };

      dwindle = {
        smart_split = false;
        smart_resizing = true;
        preserve_split = false;
        pseudotile = true;
      };

      decoration = {
        rounding = hypr.decoration.rounding;
        blur = {
          enabled = hypr.decoration.blur.enable;
          xray = true;
          special = false;
          new_optimizations = true;
          size = hypr.decoration.blur.size;
          passes = hypr.decoration.blur.passes;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          input_methods = false;
          input_methods_ignorealpha = 0.8;
        };

        shadow = {
          enabled = hypr.decoration.shadows.enable;
          ignore_window = true;
          range = 20;
          offset = "0 2";
          render_power = 3;
          color = "$_shadow";
        };

        # Window Opacities
        fullscreen_opacity = 1;

        # Dim
        dim_inactive = false;
        dim_strength = 0.15;
        dim_special = 0.3;
      }
      // lib.optionalAttrs hypr.decoration.blur.enable {
        active_opacity = hypr.decoration.blur.opacity;
        inactive_opacity = hypr.decoration.blur.opacity;
      };

      misc = {
        vfr = true;
        vrr = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_splash_rendering = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|alacritty|Alacritty|com.mitchellh.ghostty|)";

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        on_focus_under_fullscreen = 2;
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
    };
  };
}
