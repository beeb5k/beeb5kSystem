{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.beeMods.matugen.enable {
    xdg.configFile."matugen/templates/sequences" = {
      text = ''
        #!/bin/sh
        SEQ=""
        SEQ="$SEQ$(printf '\033]4;0;{{dank16.color0.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;1;{{dank16.color1.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;2;{{dank16.color2.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;3;{{dank16.color3.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;4;{{dank16.color4.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;5;{{dank16.color5.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;6;{{dank16.color6.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;7;{{dank16.color7.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;8;{{dank16.color8.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;9;{{dank16.color9.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;10;{{dank16.color10.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;11;{{dank16.color11.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;12;{{dank16.color12.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;13;{{dank16.color13.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;14;{{dank16.color14.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]4;15;{{dank16.color15.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]10;{{colors.on_surface.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]11;{{colors.background.default.hex}}\007')"
        # <* if {{ is_dark_mode }} *>
        # SEQ="$SEQ$(printf '\033]11;{{colors.background.default.hex}}\007')"
        # <* else *>
        # SEQ="$SEQ$(printf '\033]11;{{colors.surface_container.default.hex}}\007')"
        # <* endif *>
        SEQ="$SEQ$(printf '\033]12;{{colors.primary.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]17;{{colors.on_surface.default.hex}}\007')"
        SEQ="$SEQ$(printf '\033]19;{{colors.primary_container.default.hex}}\007')"

        for tty in /dev/pts/*; do
          [ -w "$tty" ] && printf '%s' "$SEQ" > "$tty"
        done
      '';
      executable = true;
    };
  };
}
