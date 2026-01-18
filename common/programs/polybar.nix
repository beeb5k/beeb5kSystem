{
  config,
  pkgs,
  ...
}: let
  polybar-bluetooth = pkgs.writeShellApplication {
    name = "polybar-bluetooth";
    runtimeInputs = with pkgs; [bluez dbus gnugrep coreutils findutils];
    text = ''
      print_status() {
          if bluetoothctl show | grep -q "Powered: yes"; then
              if bluetoothctl info | grep -q "Connected: yes"; then
                  dev=$(bluetoothctl info | grep "Alias" | cut -d: -f2 | xargs)
                  echo "$dev"
              else
                  echo "On"
              fi
          else
              echo "Off"
          fi
      }

      print_status

      # Subscribe to DBus for instant updates without polling
      dbus-monitor --system "type='signal',sender='org.bluez',member='PropertiesChanged'" 2>/dev/null | \
      grep --line-buffered "member=PropertiesChanged" | \
      while read -r _; do
        print_status
      done
    '';
  };

  polybar-network = pkgs.writeShellApplication {
    name = "polybar-network";
    runtimeInputs = with pkgs; [iproute2 networkmanager gnugrep coreutils];
    text = ''
      # 1. Logic to print current state
      print_status() {
        # Check if we have a default route (Internet connection)
        if ip route | grep -q "^default"; then
             # We are online! Get the name.
             ssid=$(nmcli -t -f NAME connection show --active | head -n1)

             # Fallback if name is empty (happens during handshake)
             if [ -z "$ssid" ]; then
                 echo "Connected..."
             else
                 echo "$ssid"
             fi
        else
             echo "Offline"
        fi
      }

      # Run once immediately
      print_status

      ip monitor route address link | \
      grep --line-buffered ".*" | \
      while read -r _; do
         print_status
      done
    '';
  };

  polybar-power = pkgs.writeShellApplication {
    name = "polybar-power";
    runtimeInputs = with pkgs; [power-profiles-daemon dbus gnugrep coreutils];
    text = ''
      print_status() {
        # ShellCheck fix: Use POSIX classes [:lower:] instead of a-z
        powerprofilesctl get 2>/dev/null | tr '[:lower:]' '[:upper:]'
      }

      print_status

      dbus-monitor --system "type='signal',sender='net.hadess.PowerProfiles'" 2>/dev/null | \
      grep --line-buffered "member=PropertiesChanged" | \
      while read -r _; do
          print_status
      done
    '';
  };

  polybar-audio = pkgs.writeShellApplication {
    name = "polybar-audio";
    runtimeInputs = with pkgs; [wireplumber pulseaudio gawk gnugrep coreutils];
    text = ''
      print_vol() {
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
          echo "MUTED"
        else
          echo "$vol%"
        fi
      }

      print_vol
      pactl subscribe | grep --line-buffered "sink" | while read -r _; do
        print_vol
      done
    '';
  };

  polybar-mic = pkgs.writeShellApplication {
    name = "polybar-mic";
    runtimeInputs = with pkgs; [wireplumber pulseaudio gawk gnugrep coreutils];
    text = ''
      get_mic_status() {
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
        if [[ "$vol" == *"MUTED"* ]]; then
          echo "MUTED"
        else
          echo "$vol" | awk '{print int($2*100) "%"}'
        fi
      }

      sleep 0.2
      get_mic_status

      pactl subscribe 2>/dev/null | grep --line-buffered "Event 'change' on source" | while read -r _; do
         get_mic_status
      done
    '';
  };
in {
  services.polybar = {
    enable = config.bspwm.enable;

    # Basic startup script
    script = "polybar main &";

    config = {
      # --- BASE SETTINGS ---
      "section/base" = {
        include-file = "~/.config/polybar/colors.ini";
      };

      "bar/main" = {
        width = "100%";
        height = "28pt";
        radius = 0;
        bottom = false;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        border-size = 0;
        padding-left = 2;
        padding-right = 2;
        module-margin = 1;

        separator = "|";
        separator-foreground = "\${colors.disabled}";

        font-0 = "IBM Plex Mono:size=10;3";

        modules-left = "bspwm";
        modules-center = "date powerprofile";
        modules-right = "memory cpu battery mic audio bluetooth network tray";

        # cursor-click = "pointer";
        # cursor-scroll = "ns-resize";
        enable-ipc = true;
        wm-restack = "bspwm";
      };

      "module/tray" = {
        type = "internal/tray";
        tray-spacing = "8px";
        tray-size = "14pt";
      };

      # --- STANDARD MODULES ---
      "module/bspwm" = {
        type = "internal/bspwm";
        pin-workspaces = true;
        inline-mode = false;
        label-focused = "%name%";
        label-focused-background = "\${colors.background-alt}";
        label-focused-underline = "\${colors.primary}";
        label-focused-padding = 1;
        label-occupied = "%name%";
        label-occupied-padding = 1;
        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 1;
        label-empty = "%name%";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = 1;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 30;
        date = "%I:%M %p";
        date-alt = "%Y-%m-%d %H:%M:%S";
        label = "%date%";
        label-foreground = "\${colors.primary}";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ACAD";
        full-at = 99;
        low-at = 10;
        poll-interval = 5;
        format-charging = "<label-charging>";
        format-charging-prefix = "CHR ";
        format-charging-prefix-foreground = "\${colors.primary}";
        format-discharging = "<label-discharging>";
        format-discharging-prefix = "BAT ";
        format-discharging-prefix-foreground = "\${colors.primary}";
        format-full = "<label-full>";
        format-full-prefix = "BAT ";
        format-full-prefix-foreground = "\${colors.primary}";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "100%";
      };

      # --- CUSTOM SCRIPTS (Fixed Click Actions) ---

      "module/bluetooth" = {
        type = "custom/script";
        tail = true;
        format-prefix = "BT ";
        format-prefix-foreground = "\${colors.primary}";
        exec = "${polybar-bluetooth}/bin/polybar-bluetooth";

        click-left = "${pkgs.writeShellScript "rofi-bt-wrapper" ''
          export PATH=$PATH:${pkgs.rofi}/bin
          ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth
        ''}";

        click-right = "${pkgs.bluez}/bin/bluetoothctl power off";
      };

      "module/network" = {
        type = "custom/script";
        tail = true;
        format-prefix = "WIFI ";
        format-prefix-foreground = "\${colors.primary}";
        exec = "${polybar-network}/bin/polybar-network";

        click-left = "${pkgs.writeShellScript "rofi-net-wrapper" ''
          export PATH=$PATH:${pkgs.rofi}/bin:${pkgs.networkmanager}/bin
          ${pkgs.rofi-network-manager}/bin/rofi-network-manager
        ''}";
      };

      "module/powerprofile" = {
        type = "custom/script";
        tail = true;
        format = "<label>";
        label = "%output%";
        label-foreground = "\${colors.foreground}";
        exec = "${polybar-power}/bin/polybar-power";

        # Toggle script is safe because we wrote it inline with paths
        click-left = "${pkgs.writeShellScript "ppd-toggle" ''
          current=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)
          case "$current" in
            power-saver) ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced ;;
            balanced)    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance ;;
            performance) ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver ;;
          esac
        ''}";
      };

      "module/audio" = {
        type = "custom/script";
        tail = true;
        format-prefix = "VOL ";
        format-prefix-foreground = "\${colors.primary}";
        exec = "${polybar-audio}/bin/polybar-audio";

        click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        click-left = "${pkgs.pavucontrol}/bin/pavucontrol -t 3";
        scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0";
        scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };

      "module/mic" = {
        type = "custom/script";
        tail = true;
        format-prefix = "MIC ";
        format-prefix-foreground = "\${colors.primary}";
        exec = "${polybar-mic}/bin/polybar-mic";

        click-left = "${pkgs.pavucontrol}/bin/pavucontrol -t 4";
        click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+ --limit 1.0";
        scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
      };
    };
  };
}
