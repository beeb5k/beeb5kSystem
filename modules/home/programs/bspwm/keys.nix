{
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

      # Volume (PipeWire/Pulse)
      "XF86AudioRaiseVolume" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

      # Microphone Mute
      "XF86AudioMicMute" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      # Brightness
      "XF86MonBrightnessUp" = "brightnessctl set +5%";
      "XF86MonBrightnessDown" = "brightnessctl set 5%-";

      # Media Controls (Spotify/YouTube)
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioNext" = "playerctl next";
      "XF86AudioPrev" = "playerctl previous";
      "XF86AudioStop" = "playerctl stop";

      "F12" = "rofi -show calc -modi calc -no-show-match -no-sort";

      # Screenshot (Requires 'maim')
      "Print" = "maim -s | xclip -selection clipboard -t image/png";
      "super + Print" = "maim -s | xclip -selection clipboard -t image/png";
      "super + shift + Print" = "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";

      # Close Window
      "super + q" = "bspc node -c";

      # Kill Window (Force Quit)
      "super + shift + q" = "bspc node -k";

      # --- WINDOW STATES (The "Modes") ---
      "super + f" = "bspc node -t ~fullscreen";

      # Toggle Floating (Float/Unfloat)
      # I recommend using Space or S for this
      "super + space" = "bspc node -t ~floating";

      # Pseudo Tiled (Like i3, respects window size)
      "super + shift + t" = "bspc node -t ~pseudo_tiled";

      # --- FOCUS & MOVEMENT (Vim Style) ---
      # Focus window (Move cursor)
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";

      # Move window (Swap places)
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";

      # --- WORKSPACES ---
      # Focus Desktop 1-9
      "super + {1-9}" = "bspc desktop -f '^{1-9}'";

      # Move window to Desktop 1-9
      "super + shift + {1-9}" = "bspc node -d '^{1-9}'";

      # --- PRESELECTION (Manual Splitting) ---
      # "I want the next window to open to the Right/Down/etc"
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

      # Cancel preselection
      "super + ctrl + space" = "bspc node -p cancel";

      # --- RESIZING ---
      # Expand window outwards
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

      # Shrink window inwards
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

      # --- BSPWM CONTROLS ---
      # Reload Config (Run after changing bspwmrc)
      "super + Escape" = "bspc wm -r";

      # Quit Bspwm (Logout)
      "super + shift + Escape" = "bspc quit";
    };
  };
}
