{
  programs.foot = {
    enable = false;
    settings = {
      main = {
        include = [
          "/home/beeb5k/.config/foot/dank-colors.ini"
        ];
        pad = "10x10";
        dpi-aware = "no";
        bold-text-in-bright = "no";
        font = "Lilex Nerd Font:size=12.5";
      };
      cursor = {
        beam-thickness = 1;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      key-bindings = {};
    };
  };

  programs.ghostty = {
    enable = false;
    enableFishIntegration = true;
    settings = {
      config-file = [
        "~/.config/ghostty/config-dankcolors"
      ];
      font-feature = [
        "calt"
        "liga"
        "dlig"
        "cv10"
        "cv06"
        "ss02"
        "ss03"
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
      window-inherit-working-directory = false;
      # custom-shader = [
      #   "shaders/cursor_warp.glsl"
      #   "shaders/sonic_boom.glsl"
      # ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        thickness = 0.0;
      };
      general = {
        import = [
          "~/.config/alacritty/dank-theme.toml"
        ];
      };
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

      font = {
        normal.family = "Lilex Nerd Font";
        size = 12;
      };
    };
  };
}
