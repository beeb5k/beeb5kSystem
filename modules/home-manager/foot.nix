{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10";
        bold-text-in-bright = "no";
        font = "JetBrainsMono Nerd Font:size=12";
      };

      cursor = {
        style = "beam";
        blink = "no";
        beam-thickness = 1;
      };
    };
  };

  # programs.ghostty = {
  #   enable = true;
  #   settings = {
  #     font-family = "JetBrainsMono Nerd Font";
  #     font-feature = [
  #       "calt"
  #       "liga"
  #       "dlig"
  #     ];
  #     font-size = 12;
  #     window-padding-x = 10;
  #     window-padding-y = 10;
  #     bold-is-bright = false;
  #     gtk-titlebar = false;
  #     gtk-single-instance = false;
  #     gtk-tabs-location = "bottom";
  #     gtk-wide-tabs = false;
  #     resize-overlay = "never";
  #     copy-on-select = false;
  #     confirm-close-surface = false;
  #     mouse-hide-while-typing = true;
  #   };
  # };
  #
  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     window = {
  #       padding = {
  #         y = 10;
  #         x = 10;
  #       };
  #       dimensions = {
  #         lines = 75;
  #         columns = 100;
  #       };
  #     };
  #
  #     cursor = {
  #       style = {
  #         shape = "Beam";
  #       };
  #       thickness = 0.0;
  #     };
  #
  #     font = {
  #       normal.family = "JetbrainsMono Nerd Font";
  #       size = 12;
  #     };
  #   };
  # };
}
