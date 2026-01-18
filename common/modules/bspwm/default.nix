{
  homeManager,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.bspwm;
in {
  options.bspwm = {
    enable = lib.mkEnableOption "bspwm polymorphic setup";
  };

  # CRITICAL FIX: Use standard "if/else" instead of "mkMerge".
  # This completely hides the 'home' block from NixOS, preventing the error.
  config = lib.mkIf cfg.enable (
    if homeManager
    then {
      # ============================================
      # MODE A: HOME MANAGER (User Config)
      # ============================================
      xsession.windowManager.bspwm = {
        enable = true;
        monitors = {
          "eDP" = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
        };

        rules = {
          "Alacritty" = {
            desktop = "1";
            follow = true;
          };
          "zen" = {
            desktop = "2";
            follow = true;
          };
          "vesktop" = {
            desktop = "3";
            follow = true;
          };
          "steam" = {
            desktop = "4";
            follow = true;
          };
        };

        settings = {
          border_width = 2;
          window_gap = 5;
          focus_follows_pointer = true;
        };

        startupPrograms = [
          "sh ~/.fehbg"
          "systemctl --user restart polybar"
          "xsetroot -cursor_name left_ptr"
        ];

        extraConfig = ''
          [ -f ~/.config/bspwm/colors.sh ] && . ~/.config/bspwm/colors.sh
          bspc config focused_border_color "$COLOR_FOCUSED"
          bspc config normal_border_color "$COLOR_NORMAL"
        '';
      };

      services.sxhkd = {
        enable = true;
        keybindings = {
          "super + Return" = "alacritty";
          "super + a" = "rofi -show drun -show-icons";
          "super + d" = "bspc desktop -l next";
          "super + b" = "zen";
          "super + v" = "rofi-e-or-c";
          "super + n" = "rofi-b-or-n";
          "super + shift + l" = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          "super + y" = "wall-picker";
          "super + e" = "nautilus";

          # Volume
          "XF86AudioRaiseVolume" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          # Brightness
          "XF86MonBrightnessUp" = "brightnessctl set +5%";
          "XF86MonBrightnessDown" = "brightnessctl set 5%-";

          # Media
          "XF86AudioPlay" = "playerctl play-pause";
          "XF86AudioNext" = "playerctl next";
          "XF86AudioPrev" = "playerctl previous";
          "XF86AudioStop" = "playerctl stop";

          "F12" = "rofi -show calc -modi calc -no-show-match -no-sort";

          # Screenshots
          "Print" = "maim -s | xclip -selection clipboard -t image/png";
          "super + Print" = "maim -s | xclip -selection clipboard -t image/png";
          "super + shift + Print" = "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";

          # Window Controls
          "super + q" = "bspc node -c";
          "super + shift + q" = "bspc node -k";
          "super + f" = "bspc node -t ~fullscreen";
          "super + space" = "bspc node -t ~floating";
          "super + shift + t" = "bspc node -t ~pseudo_tiled";

          # Movement
          "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
          "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";
          "super + {1-9}" = "bspc desktop -f '^{1-9}'";
          "super + shift + {1-9}" = "bspc node -d '^{1-9}'";
          "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
          "super + ctrl + space" = "bspc node -p cancel";
          "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
          "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

          # Session
          "super + Escape" = "bspc wm -r";
          "super + shift + Escape" = "bspc quit";
        };
      };

      home.packages = with pkgs; [
        feh
        maim
        slop
        xdotool
        xclip
        matugen
        pywal16
        imagemagick
        pavucontrol
        pulseaudio
        brightnessctl
        rofi-bluetooth
        rofi-network-manager
        rofi-power-menu
      ];
    }
    else {
      # ============================================
      # MODE B: NIXOS SYSTEM (Root Config)
      # ============================================
      services.xserver = {
        enable = true;
        autoRepeatDelay = 300;
        autoRepeatInterval = 20;
        xkb = {
          layout = "us";
          variant = "";
        };
        libinput = {
          enable = true;
          touchpad.naturalScrolling = true;
        };
        windowManager.bspwm.enable = true;
      };
    }
  );
}

