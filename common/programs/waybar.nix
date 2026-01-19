{
  pkgs,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = ["river/tags"];
        modules-center = ["clock" "custom/sep" "power-profiles-daemon"];
        modules-right = [
          "memory"
          "custom/sep"
          "cpu"
          "custom/sep"
          "battery"
          "custom/sep"
          "pulseaudio#mic"
          "custom/sep"
          "wireplumber"
          "custom/sep"
          "bluetooth"
          "custom/sep"
          "network"
          "custom/sep"
          "tray"
        ];

        # --- Modules ---

        "river/tags" = {
          num-tags = 9;
        };

        "clock" = {
          interval = 30;
          format = "{:%I:%M %p}";
          "format-alt" = "{:%Y-%m-%d %H:%M:%S}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          "format-icons" = {
            "performance" = "PERFORMANCE";
            "balanced" = "BALANCED";
            "power-saver" = "POWER-SAVE";
          };
        };

        "memory" = {
          interval = 2;
          format = "RAM {percentage}%";
        };

        "cpu" = {
          interval = 2;
          format = "CPU {usage}%";
        };

        "battery" = {
          interval = 5;
          "full-at" = 99;
          format = "BAT {capacity}%";
          "format-charging" = "CHR {capacity}%";
          "format-plugged" = "CHR {capacity}%";
          "format-full" = "BAT Full";
        };

        "wireplumber" = {
          format = "VOL {volume}%";
          "format-muted" = "VOL MUTED";
          "on-click" = "pavucontrol -t 3";
          "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          # Added to prevent boost (-l 1.0)
          "on-scroll-up" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        "pulseaudio#mic" = {
          format = "MIC {format_source}";
          "format-source" = "{volume}%";
          "format-source-muted" = "MUTED";
          "on-click" = "pavucontrol -t 4";
          "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          # Modified to prevent boost (-l 1.0)
          "on-scroll-up" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
        };

        "bluetooth" = {
          format = "BT {status}";
          # "format-disabled" = "BT Off";
          "format-connected" = "BT {device_alias}";
          "on-click" = "rofi-bluetooth";
          "on-click-right" = "bluetoothctl power off";
        };

        "network" = {
          format = "WIFI {essid}";
          "format-disconnected" = "WIFI Offline";
          "format-ethernet" = "ETH {ipaddr}";
          "on-click" = "rofi-network-manager";
        };

        "tray" = {
          "icon-size" = 14;
          "spacing" = 8;
        };

        "custom/sep" = {
          format = "|";
          tooltip = false;
        };
      };
    };

    # 2. Styling
    style = ''
      @import url("${config.home.homeDirectory}/.config/waybar/colors.css");

      * {
        font-family: "Lilex Nerd Font";
        font-size: 10pt;
        font-weight: normal; /* Fixed: No longer Bold */
        min-height: 0;
      }

      window#waybar {
        background-color: @background;
        color: @foreground;
      }

      /* --- River Tags --- */
      #tags button {
        padding: 0 5px;
        background: transparent;
        color: @disabled;
        border-bottom: 2px solid transparent;
      }

      #tags button.focused {
        color: @primary;
        border-bottom: 2px solid @primary;
        background-color: @background-alt;
        opacity: 1.0;
      }

      #tags button.occupied {
        color: @foreground;
        opacity: 1.0;
      }

      #tags button.urgent {
        background-color: @alert;
        color: @background;
        opacity: 1.0;
      }

      /* --- Modules --- */
      #clock,
      #power-profiles-daemon,
      #memory,
      #cpu,
      #battery,
      #wireplumber,
      #pulseaudio,
      #bluetooth,
      #network {
        padding: 0 5px;
        background-color: transparent;
        color: @primary;
      }

      /* --- Special States --- */
      #wireplumber.muted,
      #pulseaudio.muted {
        color: @alert;
      }

      #battery.warning,
      #battery.critical {
        color: @alert;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #custom-sep {
        color: @disabled;
        padding: 0 2px;
      }

      /* --- Tray Styling --- */
      #tray {
        padding: 0 5px;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
