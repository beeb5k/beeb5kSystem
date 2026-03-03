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
      black   = "\{{color0}}"
      red     = "\{{color1}}"
      green   = "\{{color2}}"
      yellow  = "\{{color3}}"
      blue    = "\{{color4}}"
      magenta = "\{{color5}}"
      cyan    = "\{{color6}}"
      white   = "\{{color7}}"

      [colors.bright]
      black   = "\{{color8}}"
      red     = "\{{color9}}"
      green   = "\{{color10}}"
      yellow  = "\{{color11}}"
      blue    = "\{{color12}}"
      magenta = "\{{color13}}"
      cyan    = "\{{color14}}"
      white   = "\{{color15}}"
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

        regular0=\{{color0[1:]}}
        regular1=\{{color1[1:]}}
        regular2=\{{color2[1:]}}
        regular3=\{{color3[1:]}}
        regular4=\{{color4[1:]}}
        regular5=\{{color5[1:]}}
        regular6=\{{color6[1:]}}
        regular7=\{{color7[1:]}}

        bright0=\{{color8[1:]}}
        bright1=\{{color9[1:]}}
        bright2=\{{color10[1:]}}
        bright3=\{{color11[1:]}}
        bright4=\{{color12[1:]}}
        bright5=\{{color13[1:]}}
        bright6=\{{color14[1:]}}
        bright7=\{{color15[1:]}}


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

      palette = 0=\{{color0}}
      palette = 1=\{{color1}}
      palette = 2=\{{color2}}
      palette = 3=\{{color3}}
      palette = 4=\{{color4}}
      palette = 5=\{{color5}}
      palette = 6=\{{color6}}
      palette = 7=\{{color7}}
      palette = 8=\{{color8}}
      palette = 9=\{{color9}}
      palette = 10=\{{color10}}
      palette = 11=\{{color11}}
      palette = 12=\{{color12}}
      palette = 13=\{{color13}}
      palette = 14=\{{color14}}
      palette = 15=\{{color15}}
    '';
  };

  # ST
  xdg.configFile."matugen/templates/st" = {
    text = ''
      dwm.normbordercolor : {{colors.outline.default.hex}}
      dwm.normbgcolor : {{colors.surface.default.hex}}
      dwm.normfgcolor : {{colors.on_surface.default.hex}}
      dwm.selbordercolor : {{colors.primary.default.hex}}
      dwm.selbgcolor : {{colors.surface_container.default.hex}}
      dwm.selfgcolor : {{colors.primary.default.hex}}

      st.background: {{colors.surface.default.hex}}
      st.foreground: {{colors.on_surface.default.hex}}
      st.cursorColor: {{colors.primary.default.hex}}

      st.color0: \{{color0}}
      st.color8: \{{color8}}

      st.color1: \{{color1}}
      st.color9: \{{color9}}

      st.color2: \{{color2}}
      st.color10: \{{color10}}

      st.color3: \{{color3}}
      st.color11: \{{color11}}

      st.color4: \{{color4}}
      st.color12: \{{color12}}

      st.color5: \{{color5}}
      st.color13: \{{color13}}

      st.color6: \{{color6}}
      st.color14: \{{color14}}

      st.color7: \{{color7}}
      st.color15: \{{color15}}
    '';
  };
}
