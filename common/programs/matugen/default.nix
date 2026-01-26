{
  config,
  lib,
  ...
}: {
  imports = [./templates];

  xdg.configFile = {
    "matugen/config.toml" = {
      # enable = !config.programs.noctalia-shell.enable;
      text =
        # toml
        ''
          [config]
          ${lib.optionalString config.programs.alacritty.enable ''
            [templates.alacritty]
            input_path = '~/.config/matugen/templates/alacritty-colors.toml'
            output_path = '~/.config/hellwal/templates/alacritty-colors.toml'
          ''}

          ${lib.optionalString config.programs.foot.enable ''
            [templates.foot]
            input_path = '~/.config/matugen/templates/foot-colors.ini'
            output_path = '~/.config/hellwal/templates/foot-colors.ini'
          ''}

          ${lib.optionalString config.programs.ghostty.enable ''
            [templates.ghostty]
            input_path = '~/.config/matugen/templates/ghostty.conf'
            output_path = '~/.config/hellwal/templates/ghostty-colors.conf'
          ''}

          ${lib.optionalString config.programs.zathura.enable ''
            [templates.zathura]
            input_path = '~/.config/matugen/templates/zathura.toml'
            output_path = '~/.config/zathura/matugen'
          ''}

          ${lib.optionalString config.programs.btop.enable ''
            [templates.btop]
            input_path = '~/.config/matugen/templates/btop.theme'
            output_path = '~/.config/btop/themes/matugen.theme'
          ''}

            [templates.polybar]
            input_path = "~/.config/matugen/templates/polybar-colors.ini"
            output_path = "~/.config/polybar/colors.ini"

            [templates.discord]
            input_path = "~/.config/matugen/templates/discord.css"
            output_path = "~/.config/vencord/midnight.css"

          ${lib.optionalString config.bspwm.enable ''
            [templates.bspwm]
            input_path = "~/.config/matugen/templates/bspwm-colors.sh"
            output_path = "~/.config/bspwm/colors.sh"
            post_hook = "bspc wm -r"
          ''}

            [templates.dunst]
            input_path = '~/.config/matugen/templates/dunstrc'
            output_path = '~/.cache/matugen/dunstrc'
            post_hook = "dunstctl reload"

            ${lib.optionalString config.programs.rofi.enable ''
            [templates.rofi]
            input_path = '~/.config/matugen/templates/rofi-colors.rasi'
            output_path = '~/.config/rofi/shared/colors.rasi'
          ''}

          ${lib.optionalString config.gtk.enable ''
            [templates.gtk3]
            input_path = '~/.config/matugen/templates/colors.css'
            output_path = '~/.config/gtk-3.0/colors.css'

            [templates.gtk4]
            input_path = '~/.config/matugen/templates/colors.css'
            output_path = '~/.config/gtk-4.0/colors.css'
          ''}

            [templates.zed]
            input_path = '~/.config/matugen/templates/zed.json'
            output_path = '~/.config/zed/themes/matugen.json'

            [templates.zen]
            input_path = '~/.config/matugen/templates/zen.css'
            output_path = '~/.config/hellwal/templates/userChrome.css'
        '';
    };
  };
}
