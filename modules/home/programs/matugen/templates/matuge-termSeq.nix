{
  xdg.configFile = {
    "matugen/templates/sequence.sh" = {
      enable = true;
      text =
        # sh
        ''
          printf "\033]4;0;{{colors.source_color.default.hex}}\033\\"
          printf "\033]4;1;{{colors.error.default.hex}}\033\\"
          printf "\033]4;2;{{colors.primary.default.hex}}\033\\"
          printf "\033]4;3;{{colors.inverse_primary.default.hex}}\033\\"
          printf "\033]4;4;{{colors.primary.default.hex}}\033\\"
          printf "\033]4;5;{{colors.tertiary.default.hex}}\033\\"
          printf "\033]4;6;{{colors.secondary.default.hex}}\033\\"
          printf "\033]4;7;#BAC2DE\033\\"
          printf "\033]4;8;#585B70\033\\"
          printf "\033]4;9;#F38BA8\033\\"
          printf "\033]4;10;#A6E3A1\033\\"
          printf "\033]4;11;#F9E2AF\033\\"
          printf "\033]4;12;#89B4FA\033\\"
          printf "\033]4;13;#F5C2E7\033\\"
          printf "\033]4;14;#94E2D5\033\\"
          printf "\033]4;15;#A6ADC8\033\\"

          # Background
          printf "\033]11;{{colors.background.default.hex}}\033\\";

          # Foreground
          printf "\033]10;{{colors.on_surface.default.hex}}\033\\";

          # Cursor
          printf "\033]12;{{colors.on_surface.default.hex}}\033\\";

          # Border
          printf "\033]7044;{{colors.surface_variant.default.hex}}\033\\";
        '';
    };
  };
}
