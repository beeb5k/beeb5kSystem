{
  config,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.beeMods.terminal.foot {
      xdg.configFile."matugen/templates/foot-colors.ini" = {
        text = ''
          [colors-dark]
          foreground={{colors.on_surface.default.hex_stripped}}
          <* if {{ is_dark_mode }} *>
          background={{colors.background.default.hex_stripped}}
          <* else *>
          background={{colors.surface_container.default.hex_stripped}}
          <* endif *>
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
    })
    (lib.mkIf config.beeMods.terminal.alacritty {
      xdg.configFile."matugen/templates/alacritty-colors.toml" = {
        text = ''
          [colors.primary]
          <* if {{ is_dark_mode }} *>
          background = '{{colors.background.default.hex}}'
          <* else *>
          background = '{{colors.surface_container.default.hex}}'
          <* endif *>
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
    })
    (lib.mkIf config.beeMods.terminal.ghostty {
      xdg.configFile."matugen/templates/ghostty.conf" = {
        text = ''
          <* if {{ is_dark_mode }} *>
          background = {{colors.background.default.hex}}
          <* else *>
          background = {{colors.surface_container.default.hex}}
          <* endif *>
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
    })
  ];
}
