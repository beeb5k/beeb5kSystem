{
  #alacritty
  xdg.configFile."matugen/templates/alacritty-colors.toml" = {
    text = ''
      [colors.primary]
      background = '{{colors.background.default.hex}}'
      foreground = '{{colors.on_surface.default.hex}}'

      [colors.selection]
      text = '{{colors.on_surface.default.hex}}'
      background = '{{colors.primary_container.default.hex}}'

      [colors.cursor]
      text = '{{colors.background.default.hex}}'
      cursor = '{{colors.primary.default.hex}}'

      [colors.normal]
      black   = '#%%color0.hex%%'
      red     = '#%%color1.hex%%'
      green   = '#%%color2.hex%%'
      yellow  = '#%%color3.hex%%'
      blue    = '#%%color4.hex%%'
      magenta = '#%%color5.hex%%'
      cyan    = '#%%color6.hex%%'
      white   = '#%%color7.hex%%'

      [colors.bright]
      black   = '#%%color8.hex%%'
      red     = '#%%color9.hex%%'
      green   = '#%%color10.hex%%'
      yellow  = '#%%color11.hex%%'
      blue    = '#%%color12.hex%%'
      magenta = '#%%color13.hex%%'
      cyan    = '#%%color14.hex%%'
      white   = '#%%color15.hex%%'
    '';
  };

  # foot
  xdg.configFile."matugen/templates/foot-colors.ini" = {
    text = ''
      [colors]
      foreground={{colors.on_surface.default.hex_stripped}}
      background={{colors.background.default.hex_stripped}}
      selection-foreground={{colors.on_surface.default.hex_stripped}}
      selection-background={{colors.primary_container.default.hex_stripped}}
      cursor = {{colors.background.default.hex_stripped}} {{colors.primary.default.hex_stripped}}

      regular0=%%color0%%
      regular1=%%color1%%
      regular2=%%color2%%
      regular3=%%color3%%
      regular4=%%color4%%
      regular5=%%color5%%
      regular6=%%color6%%
      regular7=%%color7%%
      bright0=%%color8%%
      bright1=%%color9%%
      bright2=%%color10%%
      bright3=%%color11%%
      bright4=%%color12%%
      bright5=%%color13%%
      bright6=%%color14%%
      bright7=%%color15%%

      dim-blend-towards=<* if {{ is_dark_mode }} *>black<* else *>white<* endif *>
    '';
  };

  #ghostty
  xdg.configFile."matugen/templates/ghostty.conf" = {
    text = ''
      background = {{colors.background.default.hex}}
      foreground = {{colors.on_surface.default.hex}}
      cursor-color = {{colors.primary.default.hex}}
      selection-background = {{colors.primary_container.default.hex}}
      selection-foreground = {{colors.on_surface.default.hex}}

      palette = 0=%%color0%%
      palette = 1=%%color1%%
      palette = 2=%%color2%%
      palette = 3=%%color3%%
      palette = 4=%%color4%%
      palette = 5=%%color5%%
      palette = 6=%%color6%%
      palette = 7=%%color7%%
      palette = 8=%%color8%%
      palette = 9=%%color9%%
      palette = 10=%%color10%%
      palette = 11=%%color11%%
      palette = 12=%%color12%%
      palette = 13=%%color13%%
      palette = 14=%%color14%%
      palette = 15=%%color15%%
    '';
  };
}
