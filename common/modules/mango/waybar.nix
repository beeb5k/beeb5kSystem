{ pkgs, ... }:
let
  screenshot = pkgs.writeShellScript "screenshot" ''
    GEOM=$(${pkgs.slurp}/bin/slurp -b '#2E2A1E55' -c '#fb751bff') || exit
    ${pkgs.grim}/bin/grim -g "$GEOM" -t ppm - | ${pkgs.satty}/bin/satty --filename -
  '';
in
{
  xdg.configFile = {
    "waybar/config.jsonc" = {
      enable = true;
      text = ''
        {
            "layer": "top",
            "position": "top",
            "exclusive": true,
            "passthrough": false,
            "gtk-layer-shell": true,
            "ipc": false,
            "reload_style_on_change": true,
            "height": 35,
            "modules-left": [
                "dwl/tags",
                "wlr/taskbar",
                "dwl/window"
            ],
            "modules-center": [
                "mpris"
            ],
            "modules-right": [
                "tray",
                "power-profiles-daemon",
                "network",
                "group/hardware",
                "upower",
                "clock",
                "custom/power"
            ],

            "group/hardware": {
                "orientation": "horizontal",
                "modules": [
                    "pulseaudio",
                    "pulseaudio#microphone",
                    "cpu",
                    "backlight"
                ]
            },

            "dwl/tags": {
              "num-tags": 9,
              "hide-vacant": true,
              "tag-labels": ["一", "二", "三", "四", "五", "六", "七", "八", "九"]
            },
            "dwl/window": {
                "format": "[{layout}]{title}",
                "on-click":"${screenshot}"
            },
            "cpu": {
              "interval": 2,
              "format": " {load}%"
            },
            "wlr/taskbar": {
              "format": "{icon}",
              "icon-size": 22,
              "all-outputs": false,
              "tooltip-format": "{title}",
              "markup": true,
              "on-click": "activate",
              "on-click-right": "close",
              "ignore-list": ["Rofi", "wofi"]
            },
            "backlight": {
              "interval": 2,
              "format": "{icon} {percent}%",
              "format-icons": ["󰖔", "󰖨"],
              "on-scroll-up": "brightnessctl set +1%",
              "on-scroll-down": "brightnessctl set 1%-",
              "smooth-scrolling-threshold": 1
            },
            "idle_inhibitor": {
                "tooltip": false,
                "format": "{icon}",
                "start-activated": false,
                "format-icons": {
                    "activated": " ",
                    "deactivated": " "
                }
            },
            "tray": {
              "interval": 1,
              "icon-size": 21,
              "spacing": 10
            },
            "network": {
              "interval": 2,
              "format-wifi": "{essid} ({signalStrength}%) \uf1eb ",
              "format-ethernet": "󰈀 {ifname}",
              "format-linked": "\uf059 No IP ({ifname})",
              "format-disconnected": "\uf071 Disconnected",
              "tooltip-format": "{ifname} {ipaddr}/{cidr} via {gwaddr}",
              "format-alt": "↓{bandwidthDownBytes} ↑{bandwidthUpBytes}"
            },
            "clock": {
              "format": "{:%H:%M} ",
              "format-alt": "{:%A, %b %d} ",
              "tooltip-format": "{:%Y}",
              "calendar": {
                "mode": "year",
                "mode-mon-col": 3,
                "weeks-pos": "right",
                "on-scroll": 1,
                "format": {
                  "months": "<span color='#ffead3'><b>{}</b></span>",
                  "days": "<span color='#ecc6d9'><b>{}</b></span>",
                  "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                  "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                  "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
                }
              }
            },
            "pulseaudio": {
                "format": "{icon} {volume}%",
                "tooltip": false,
                "format-muted": " Muted",
                "format-bluetooth": " {volume}%",
                "format-bluetooth-muted": " Muted",
                "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
                "on-scroll-up": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+",
                "on-scroll-down": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%-",
                "scroll-step": 5,
                "format-icons": {
                    "headphone": "",
                    "hands-free": "",
                    "headset": "",
                    "phone": "",
                    "portable": "",
                    "car": "",
                    "default": ["", "", ""]
                },
                "ignored-sinks": ["Easy Effects Sink"]
            },
            "pulseaudio#microphone": {
                "format": "{format_source}",
                "format-source": " {volume}%",
                "tooltip": false,
                "format-source-muted": " Muted",
                "on-click": "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
                "on-scroll-up": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 2%+",
                "on-scroll-down": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 2%-",
                "scroll-step": 5
            },
            "custom/power": {
                "format": "",
                "tooltip": false,
                "on-click": "wlogout -C ~/.config/wlogout/style.css -l  ~/.config/wlogout/layout  -b 6 --protocol layer-shell"
            },

            "power-profiles-daemon": {
              "format": "{icon}",
              "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
              "tooltip": true,
              "format-icons": {
                "default": " ",
                "performance": " ",
                "balanced": " ",
                "power-saver": " "
              }
            },

            "mpris": {
                "format": "{player_icon} {title} - {artist}",
                "format-paused": "{status_icon} {title} - {artist}",
                "format-stopped": "",
                "max-length": 45,
                "ellipsis": true,
                "tooltip": false,
                "playerctld": false,
                "player-icons": {
                    "default": "",
                    "spotify": "",
                    "firefox": "",
                    "mpv": ""
                },
                "status-icons": {
                    "paused": "",
                    "playing": ""
                },
                "on-click": "playerctl play-pause",
                "on-click-right": "playerctl next",
                "on-click-middle": "playerctl previous",
                "on-scroll-up": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+",
                "on-scroll-down": "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%-"
            },
            "cava": {
                "framerate": 60,
                "autosens": 0,
                "bars": 8,
                "lower_cutoff_freq": 50,
                "higher_cutoff_freq": 12000,
                "method": "pipewire",
                "hide_on_silence": true,
                "sleep_timer": 5,
                "source": "auto",
                "stereo": false,
                "reverse": false,
                "bar_delimiter": 0,
                "monstercat": false,
                "waves": false,
                "noise_reduction": 0.77,
                "input_delay": 0,
                "format-icons" : ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ],
                "actions": {
                    "on-click-right": "mode"
                }
            },

            "upower": {
                "icon-size": 18,
                "hide-if-empty": true,
                "tooltip": true,
                "tooltip-spacing": 20,
                "format": "{percentage}"
            }
        }
      '';
    };

    "waybar/style.css" = {
      enable = true;
      text = ''
        * {
          border: none;
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-weight: 700;
          font-size: 14px;
          min-height: 0;
        }

        window#waybar {
          background: none;
          margin: 0px;
          padding: 0px;
        }

        @import url("colors.css");

        tooltip {
          background: @bg_panel;
          border-radius: 0px;
          border-width: 2px;
          border-style: solid;
          border-color: @border_color;
          color: @text_main;
        }

        #window,
        #taskbar,
        #tags,
        #workspaces,
        #mpris,
        #clock,
        #upower,
        #network,
        #tray,
        #cava,
        #custom-power,
        #power-profiles-daemon,
        #hardware {
          background: @bg_panel;
          color: @text_main;
          padding: 0px 8px;
          margin: 0px;
          margin-top: 1px;
          margin-bottom: 0px;
          border-width: 2px;
          border-style: solid;
          border-color: @border_color;
          border-radius: 0px;
        }

        #workspaces button,
        #tags button {
          border: none;
          background: none;
          box-shadow: inherit;
          text-shadow: inherit;
          padding: 1px;
        }

        #workspaces button:hover,
        #tags button:hover {
          color: @text_accent;
        }


        #workspaces button.active,
        #tags button.focused,
        #taskbar button.active {
          background-color: @text_main;
        }

        #workspaces button.urgent,
        #tags button.urgent {
          background-color: @alert_urgent;
        }

        #taskbar button.urgent {
          background-color: @alert_critical;
        }

        #taskbar button.minimized {
          background-color: @alert_minimized;
        }

        #taskbar button.active,
        #taskbar button.urgent,
        #taskbar button.minimized {
          padding-left: 3px;
          padding-right: 3px;
        }

        #hardware {
          padding: 0px;
          margin-right: 4px;
        }

        #hardware > widget > * {
          padding: 0px 8px;
        }

        #workspaces {
          margin-left: 4px;
          padding-left: 10px;
          padding-right: 6px;
        }

        #workspaces button {
          color: @text_main;
          margin-right: 2px;
          margin-left: 2px;
        }

        #workspaces button.hidden {
          color: @text_muted;
          background-color: transparent;
        }

        #workspaces button.visible {
          color: @text_main;
        }

        #tags {
          margin-left: 5px;
          padding-left: 10px;
          padding-right: 6px;
        }

        #taskbar button {
          color: @text_dim;
          margin-top: 2px;
          margin-bottom: 2px;
          margin-right: 4px;
          padding: 0px 3px;
          border-radius: 0px;
          background: transparent;
        }

        #tags button:not(.occupied):not(.focused):not(.overview):not(.urgent) {
          font-size: 0;
          min-width: 0;
          min-height: 0;
          margin: -17px;
          padding: 0;
          color: transparent;
          background-color: transparent;
        }

        #tags button.occupied,
        #tags button.overview {
          color: @text_main;
        }

        #tray {
          margin-right: 4px;
          margin-left: 4px;
          padding: 0px 9px 0px 9px;
        }

        #power-profiles-daemon,
        #network {
          margin-right: 4px;
          padding: 0px 8px 0px 9px;
        }

        #window {
          margin-right: 10px;
        }

        #taskbar {
          margin-left: 10px;
          margin-right: 10px;
        }

        #taskbar.empty {
          margin: 0px;
          padding-left: 10px;
          padding-right: 0px;
          border-color: transparent;
          border: none;
          background-color: transparent;
        }

        #taskbar button {
          margin-right: 3px;
        }

        #mpris {
          margin-left: 4px;
        }

        #cava {
          margin-left: 4px;
        }

        #clock {
          border-right: 2px;
        }

        #upower {
          margin-right: 4px;
        }

        #custom-power {
          border-left: 0px;
          margin-left: 0px;
          margin-right: 5px;
          padding-right: 14px;
        }

        #workspaces button.active,
        #workspaces button.urgent,
        #tags button.focused,
        #tags button.urgent,
        #taskbar button.active,
        #taskbar button.urgent,
        #taskbar button.minimized {
          color: @text_dark;
          margin-top: 2px;
          margin-bottom: 2px;
          padding-top: 0px;
          padding-bottom: 0px;
          border-radius: 0px;
        }
      '';
    };
  };
}
