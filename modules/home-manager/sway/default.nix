{ config, ... }:

{
  imports = [
    ./swayidle.nix
    ./swaylock.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd = {
      xdgAutostart = false;
      extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user start xdg-desktop-portal.service"
        "systemctl --user start sway-session.target"
        "swaymsg -mt subscribe '[]' || true"
        "systemctl --user stop sway-session.target"
      ];
    };

    config = {
      modifier = "Mod4";
      terminal = "footclient";
      menu = "wofi --show drun --prompt ''";

      startup = [ { command = "foot --server"; } { command = "eww open bar"; } ];

      gaps = {
        smartGaps = true;
        smartBorders = "no_gaps";
        outer = 4;
        inner = 4;
      };

      window = {
        titlebar = false;
        border = 2;
      };

      floating = {
        titlebar = false;
        border = 0;
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled";
          middle_emulation = "enabled";
          scroll_method = "two_finger";
          accel_profile = "adaptive";
          pointer_accel = "0.3";
          click_method = "clickfinger";
          drag = "enabled";
          drag_lock = "enabled";
        };

        "type:keyboard" = {
          repeat_rate = "70";
          repeat_delay = "300";
          # xkb_options = "ctrl:nocaps"; # remap capslock to ctrl
        };
      };

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;

          workspaceBindings = builtins.listToAttrs (
            builtins.genList (
              i:
              let
                n = toString (i + 1);
              in
              {
                name = "${mod}+${n}";
                value = "workspace number ${n}";
              }
            ) 9
          );

          moveToWorkspaceBindings = builtins.listToAttrs (
            builtins.genList (
              i:
              let
                n = toString (i + 1);
              in
              {
                name = "${mod}+Shift+${n}";
                value = "move container to workspace number ${n}";
              }
            ) 9
          );
        in
        workspaceBindings
        // moveToWorkspaceBindings
        // {

          "${mod}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
          "${mod}+d" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "${mod}+q" = "kill";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" = ''
            exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' \
            -B 'Yes, exit sway' 'swaymsg exit'
          '';

          # Movement
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Layout
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          # Scratchpad
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";

          # Resize mode
          "${mod}+r" = "mode resize";

          # Screenshot
          "Print" = "exec screenshot";

          # Volume controls
          "XF86AudioMute" = "exec pamixer --toggle-mute";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # Brightness
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        };

      modes = {
        resize = {
          h = "resize shrink width 10px";
          j = "resize grow height 10px";
          k = "resize shrink height 10px";
          l = "resize grow width 10px";
          Left = "resize shrink width 10px";
          Down = "resize grow height 10px";
          Up = "resize shrink height 10px";
          Right = "resize grow width 10px";
          Return = "mode default";
          Escape = "mode default";
        };
      };

      bars = [];

      # bars = [
      #   {
      #     position = "bottom";
      #     statusCommand = "while date +'%Y-%m-%d %X'; do sleep 1; done";
      #     colors = {
      #       statusline = "#ffffff";
      #       background = "#323232";
      #       inactiveWorkspace = {
      #         border = "#32323200";
      #         background = "#32323200";
      #         text = "#5c5c5c";
      #       };
      #     };
      #   }
      # ];
    };
  };
}
