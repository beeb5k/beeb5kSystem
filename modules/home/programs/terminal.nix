{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10";
        dpi-aware = "no";
        bold-text-in-bright = "no";
        font = "Lilex Nerd Font:size=12";
      };
      cursor = {
        beam-thickness = 1;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      key-bindings = { };
    };
  };

  programs.kitty = {
    enable = false;
    themeFile = "Catppuccin-Macchiato";
    font = {
      name = "Iosevka Term Nerd Font";
      size = 13;
    };

    settings = {
      enable_audio_bell = false;
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-feature = [
        "calt"
        "liga"
        "dlig"
        "cv10"
      ];
      font-family = "Lilex Nerd Font";

      font-size = 12;
      window-padding-x = 10;
      window-padding-y = 10;
      bold-is-bright = false;
      gtk-titlebar = false;
      gtk-single-instance = false;
      gtk-tabs-location = "bottom";
      gtk-wide-tabs = false;
      resize-overlay = "never";
      copy-on-select = false;
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      custom-shader-animation = "always";
      custom-shader = [
        "shaders/cursor_warp.glsl"
        "shaders/sonic_boom.glsl"
      ];
    };
  };

  programs.alacritty = {
    enable = false;
    settings = {
      window = {
        padding = {
          y = 10;
          x = 10;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      # cursor = {
      #   style = {
      #     shape = "Beam";
      #   };
      #   thickness = 0.0;
      # };

      font = {
        normal.family = "Lilex Nerd Fon";
        size = 12;
      };
    };
  };
}
