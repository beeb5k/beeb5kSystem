{
  homeManager,
  inputs,
  moduleNameSpace,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.${moduleNameSpace}.windowManagers;
  smart-alacritty = pkgs.writeShellScript "smart-alacritty" ''
    alacritty msg create-window || exec alacritty
  '';

  smart-ghostty = pkgs.writeShellScript "smart-ghostty" ''
    ghostty +new-window || exec ghostty
  '';

  terminal =
    if config.beeMods.terminal.default == "alacritty" then
      smart-alacritty
    else if config.beeMods.terminal.default == "ghostty" then
      smart-ghostty
    else
      config.beeMods.terminal.default;
in
{
  config = lib.mkIf cfg.hyprland.enable (
    if homeManager then
      {
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = true;
          systemd.variables = [ "--all" ];
          xwayland.enable = true;
          systemd.enableXdgAutostart = false;
          extraConfig = ''
            layerrule {
            name = noctalia
            match:namespace = noctalia-background-.*$
            ignore_alpha = 0.5
            blur = true
            blur_popups = true
            }
          '';

          settings = {
            monitor = [ ",1920x1080@120,auto,1.0" ];

            source =
              [ ] ++ lib.optional (config.beeMods.matugen.enable) "~/.config/hypr/noctalia/noctalia-colors.conf";

            "$mainMod" = "SUPER";

            env = [
              "NIXOS_OZONE_WL,1"
              "QT_AUTO_SCREEN_SCALE_FACTOR,1"
              "ELECTRON_OZONE_PLATFORM_HINT,auto"
              "QT_QPA_PLATFORM,wayland;xcb"
              "XDG_SESSION_TYPE,wayland"
              "GDK_BACKEND,wayland,x11"
              "GDK_SCALE,1"
            ];

            exec-once = [
              # "dbus-update-activation-environment --all"
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "gnome-keyring-daemon --start --components=secrets"
              "noctalia-shell"
            ]
            ++ lib.optionals config.beeMods.windowManagers.dwm.enable [
              "systemctl --user stop xidlehook.service"
              "systemctl --user stop xautolock-session.service"
              "systemctl --user stop xss-lock.service"
              "systemctl --user stop clipcat.service"
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
              numlock_by_default = false;
              left_handed = false;

              touchpad = {
                natural_scroll = true;
                tap-to-click = true;
                drag_lock = true;
                disable_while_typing = true;
                middle_button_emulation = false;
              };
            };

            general = {
              layout = "master";
              gaps_in = 4;
              gaps_out = 4;
              border_size = 2;

              resize_on_border = true;
              no_focus_fallback = true;
              allow_tearing = true;
            };

            master = {
              allow_small_split = true;
              new_on_top = false;
              mfact = 0.56;
            };

            scrolling = {
              column_width = 0.55;
              follow_focus = true;
            };

            decoration = {
              rounding = cfg.eyeCandy.window.borderRadius;

              blur = {
                enabled = cfg.eyeCandy.window.blur.enable;
                size = cfg.eyeCandy.window.blur.radius;
                passes = cfg.eyeCandy.window.blur.passes;
                brightness = 0.9;
                contrast = 0.9;
                noise = 0.02;
                vibrancy = 1.2;
                popups = true;
                popups_ignorealpha = 0.6;
              };

              shadow = {
                enabled = cfg.eyeCandy.window.shadows.enable;
                ignore_window = true;
                range = 10;
                render_power = 3;
                offset = "0 0";
                color = "rgba(00000044)";
              };

              # Apply opacity logic utilizing cfg.eyeCandy.options
              active_opacity =
                if (cfg.eyeCandy.window.blur.enable && cfg.eyeCandy.window.opacity == 1.0) then
                  0.82
                else
                  cfg.eyeCandy.window.opacity;
              inactive_opacity =
                if (cfg.eyeCandy.window.blur.enable && cfg.eyeCandy.window.opacity == 1.0) then
                  0.82
                else
                  cfg.eyeCandy.window.opacity;
              fullscreen_opacity = 1.0;

              dim_inactive = false;
            };

            animations = {
              enabled = cfg.eyeCandy.animations.enable;

              bezier = [
                "openCurve, 0.05, 0.7, 0.1, 1.0"
                "closeCurve, 0.0, 0.0, 1.0, 1.0"
                "moveCurve, 0.46, 1.0, 0.29, 1.0"
              ];

              animation = [
                "windowsIn, 1, 2.8, openCurve, slide"
                "windowsOut, 1, 6.5, closeCurve, popin 80%"
                "windowsMove, 1, 2.2, moveCurve"
                "fadeIn, 0, 3.0, fadeCurve"
                "fadeOut, 1, 2.5, moveCurve"
                "workspaces, 1, 2.5, moveCurve, slide"
              ];
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
              focus_on_activate = true;
            };

            binds = {
              scroll_event_delay = 0;
              focus_preferred_method = 1;
            };

            windowrule = [
              "workspace 1, match:class ^(foot|footclient|alacritty|com.mitchellh.ghostty)$"
              "workspace 2, match:class ^(zen|firefox|obsidian)$"
              "workspace 3, match:class ^(vesktop|discord|thunderbird|Element|equibop)$"
              "workspace 4, match:class ^(steam)$"
              "float on, match:class ^(org.gnome.Calculator|org.pulseaudio.pavucontrol)$"
              "stay_focused on, match:class ^(pinentry-)(.*)$"
            ];

            layerrule = [
              "no_anim on, match:namespace ^rofi$"
              "no_anim on, match:namespace ^(dms)$"
              "no_anim on, match:namespace .*dms.*"
              "no_anim on, match:namespace .*noctalia.*"
            ];

            workspace = [ "2, layout:scrolling" ];

            bind = [
              "$mainMod, r, exec, hyprctl reload"
              "$mainMod, Return, exec, ${terminal}"
              "$mainMod, a, exec,noctalia-shell ipc call launcher toggle"
              "$mainMod, y, exec,noctalia-shell ipc call wallpaper toggle"
              "$mainMod, v, exec,noctalia-shell ipc call launcher clipboard"
              "$mainMod, n, exec,noctalia-shell ipc call notifications toggleHistory"

              "$mainMod, comma, exec,noctalia-shell ipc call settings toggle"
              "$mainMod, Period, exec,noctalia-shell ipc call launcher emoji"

              "ALT, F4, exec,noctalia-shell ipc call sessionMenu toggle"
              "$mainMod, F12, exec, gnome-calculator"
              "$mainMod, b, exec, zen"
              "$mainMod, e, exec, nautilus"

              "$mainMod, m, exit,"
              "$mainMod, q, killactive,"

              "$mainMod, h, movefocus, l"
              "$mainMod, l, movefocus, r"
              "$mainMod, k, movefocus, u"
              "$mainMod, j, movefocus, d"

              ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy screen"
              "$mainMod, Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"

              "$mainMod SHIFT, k, swapwindow, u"
              "$mainMod SHIFT, j, swapwindow, d"
              "$mainMod SHIFT, h, swapwindow, l"
              "$mainMod SHIFT, l, swapwindow, r"

              "$mainMod, g, pin,"
              "ALT, Tab, workspace, previous"
              "$mainMod, space, togglefloating,"
              "ALT, a, fullscreen, 1"
              "ALT, f, fullscreen, 0"
              "$mainMod, i, togglespecialworkspace, minimized"
              "$mainMod, i, movetoworkspacesilent, special:minimized"
              "$mainMod SHIFT, i, togglespecialworkspace, minimized"
              "$mainMod SHIFT, i, movetoworkspace, +0"
              "ALT, z, togglespecialworkspace, scratchpad"

              "$mainMod, n, exec, beesettings layout"

              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, 6, workspace, 6"
              "$mainMod, 7, workspace, 7"
              "$mainMod, 8, workspace, 8"
              "$mainMod, 9, workspace, 9"

              "$mainMod SHIFT, 1, movetoworkspace, 1"
              "$mainMod SHIFT, 2, movetoworkspace, 2"
              "$mainMod SHIFT, 3, movetoworkspace, 3"
              "$mainMod SHIFT, 4, movetoworkspace, 4"
              "$mainMod SHIFT, 5, movetoworkspace, 5"
              "$mainMod SHIFT, 6, movetoworkspace, 6"
              "$mainMod SHIFT, 7, movetoworkspace, 7"
              "$mainMod SHIFT, 8, movetoworkspace, 8"
              "$mainMod SHIFT, 9, movetoworkspace, 9"

              "ALT SHIFT, Left, focusmonitor, l"
              "ALT SHIFT, Right, focusmonitor, r"
              "$mainMod ALT, Left, movecurrentworkspacetomonitor, l"
              "$mainMod ALT, Right, movecurrentworkspacetomonitor, r"
            ];

            binde = [
              "$mainMod, Up, moveactive, 0 -50"
              "$mainMod, Down, moveactive, 0 50"
              "$mainMod, Left, moveactive, -50 0"
              "$mainMod, Right, moveactive, 50 0"

              "ALT, k, resizeactive, 0 -50"
              "ALT, j, resizeactive, 0 50"
              "ALT, h, resizeactive, -50 0"
              "ALT, l, resizeactive, 50 0"
            ];

            bindel = [
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMute, exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ", XF86AudioMicMute, exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

              ", XF86AudioPlay, exec, playerctl play-pause"
              ", XF86AudioNext, exec, playerctl next"
              ", XF86AudioPrev, exec, playerctl previous"
              ", XF86AudioStop, exec, playerctl stop"

              ", XF86MonBrightnessUp, exec,brightnessctl set +5%"
              ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
            ];

            bindm = [
              "$mainMod, mouse:272, movewindow"
              "$mainMod, mouse:273, resizewindow"
            ];
          };
        };
      }
    else
      {
        programs.hyprland = {
          enable = true;
          withUWSM = false;
        };
      }
  );
}
