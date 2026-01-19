{
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
      black   = '{color0}'
      red     = '{color1}'
      green   = '{color2}'
      yellow  = '{color3}'
      blue    = '{color4}'
      magenta = '{color5}'
      cyan    = '{color6}'
      white   = '{color7}'

      [colors.bright]
      black   = '{color8}'
      red     = '{color9}'
      green   = '{color10}'
      yellow  = '{color11}'
      blue    = '{color12}'
      magenta = '{color13}'
      cyan    = '{color14}'
      white   = '{color15}'
    '';
  };
}
