{
  config,
  lib,
  ...
}: {
  imports = [./templates];

  xdg.configFile = {
    "matugen/config.toml" = {
      enable = config.bspwm.enable;
      text =
        # toml
        ''
          [config]
          version_check = true

          ${lib.optionalString config.bspwm.enable ''
            [templates.bspwm]
            input_path = "~/.config/matugen/templates/bspwm-colors.sh"
            output_path = "~/.config/bspwm/colors.sh"
            post_hook = "bspc wm -r"

            [templates.polybar]
            input_path = "~/.config/matugen/templates/polybar-colors.ini"
            output_path = "~/.config/polybar/colors.ini"

            [templates.dunst]
            input_path = '~/.config/matugen/templates/dunstrc'
            output_path = '~/.cache/matugen/dunstrc'
            post_hook = "dunstctl reload"
          ''}

          ${lib.optionalString config.programs.alacritty.enable ''
            [templates.alacritty]
            input_path = '~/.config/matugen/templates/alacritty-colors.toml'
            output_path = '~/.config/wal/templates/alacritty-colors.toml'
          ''}

          ${lib.optionalString config.programs.rofi.enable ''
            [templates.rofi]
            input_path = '~/.config/matugen/templates/rofi-colors.rasi'
            output_path = '~/.config/rofi/shared/colors.rasi'
          ''}

          ${lib.optionalString config.programs.zathura.enable ''
            [templates.zathura]
            input_path = '~/.config/matugen/templates/zathura.toml'
            output_path = '~/.config/zathura/matugen'
          ''}

          [templates.discord]
          input_path = '~/.config/matugen/templates/midnight-discord.css'
          output_path = '~/.config/Equicord/themes/midnight.css'

          [templates.vesktop]
          input_path = '~/.config/matugen/templates/midnight-discord.css'
          output_path = '~/.config/vesktop/themes/bidnight.css'

          ${lib.optionalString config.programs.yazi.enable ''
            [templates.yazi]
            input_path = '~/.config/matugen/templates/yazi.toml'
            output_path = '~/.config/yazi/theme.toml'
          ''}

          ${lib.optionalString config.programs.fuzzel.enable ''
            [templates.fuzzel]
            input_path = '~/.config/matugen/templates/fuzzel.ini'
            output_path = '~/.config/fuzzel/fuzzel.ini'
          ''}

          ${lib.optionalString config.programs.btop.enable ''
            [templates.btop]
            input_path = '~/.config/matugen/templates/btop.theme'
            output_path = '~/.config/btop/themes/matugen.theme'
          ''}

          ${lib.optionalString config.gtk.enable ''
            [templates.gtk3]
            input_path = '~/.config/matugen/templates/colors.css'
            output_path = '~/.config/gtk-3.0/colors.css'

            [templates.gtk4]
            input_path = '~/.config/matugen/templates/colors.css'
            output_path = '~/.config/gtk-4.0/colors.css'
          ''}

          ${lib.optionalString config.programs.waybar.enable ''
            [templates.waybar]
            input_path = "~/.config/matugen/templates/waybar-colors.css"
            output_path = "~/.config/waybar/colors.css"
            post_hook = "pkill -SIGUSR2 waybar"
          ''}

            [templates.zed]
            input_path = '~/.config/matugen/templates/zed.json'
            output_path = '~/.config/zed/themes/matugen.json'

            [templates.zen]
            input_path = '~/.config/matugen/templates/zen.css'
            output_path = '~/.config/wal/templates/userChrome.css'
        '';
    };
  };
}
