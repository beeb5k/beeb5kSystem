{
  xdg.configFile."matugen/templates/foot-colors.ini" = {
    text = ''
      [colors]
      foreground={{colors.on_surface.default.hex_stripped}}
      background={{colors.background.default.hex_stripped}}
      selection-foreground={{colors.on_surface.default.hex_stripped}}
      selection-background={{colors.primary_container.default.hex_stripped}}
      cursor = {{colors.background.default.hex_stripped}} {{colors.primary.default.hex_stripped}}

      regular0={color0.strip}
      regular1={color1.strip}
      regular2={color2.strip}
      regular3={color3.strip}
      regular4={color4.strip}
      regular5={color5.strip}
      regular6={color6.strip}
      regular7={color7.strip}
      bright0={color8.strip}
      bright1={color9.strip}
      bright2={color10.strip}
      bright3={color11.strip}
      bright4={color12.strip}
      bright5={color13.strip}
      bright6={color14.strip}
      bright7={color15.strip}

      dim-blend-towards=<* if {{ is_dark_mode }} *>black<* else *>white<* endif *>
    '';
  };
}
