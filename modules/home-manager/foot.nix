{
  programs.foot = {
    enable = true;
    # settings = {
    #     main = {
    #       # include = "~/.config/foot/foot-color.ini";
    #       pad = "10x10";
    #       bold-text-in-bright = "no";
    #       font = "JetBrainsMono Nerd Font:size=12";
    #     };

    #     cursor = {
    #       style = "beam";
    #       blink = "no";
    #       beam-thickness = 1.3;
    #     };
    #   };
  };

  xdg.configFile."foot/foot.ini".text = ''
    include = ~/.config/foot/foot-colors.ini
    [main]
    bold-text-in-bright=no
    font=JetBrainsMono Nerd Font:size=12
    pad=10x10

    [cursor]
    beam-thickness=1.300000
    blink=no
    style=beam
  '';
}
