{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10";
        # dpi-aware = "no";
        bold-text-in-bright = "no";
        font = "Iosevka Term Nerd Font:size=12.5";
      };
    };
  };

  programs.ghostty = {
    enable = false;
    settings = {
      font-family = "Iosevka Term Nerd Font";
      font-feature = [
        "calt"
        "liga"
        "dlig"
      ];
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
        normal.family = "Iosevka Term Nerd Font";
        size = 12.5;
      };
    };
  };
}
