{
  config,
  lib,
  ...
}: {
  imports = [./templates];

  xdg.configFile = {
    "matugen/config.toml" = {
      enable = config.hyprland.enable || config.bspwm.enable;
      text =
        # toml
        ''
          [config]
          version_check = true

          ${lib.optionalString config.bspwm.enable ''
            [config.wallpaper]
            command = "feh"
            arguments = ["--bg-fill"]
            set = false

            [templates.bspwm]
            input_path = "~/.config/matugen/templates/bspwm-colors.sh"
            output_path = "~/.config/bspwm/colors.sh"
            post_hook = "bspc wm -r"

            [templates.polybar]
            input_path = "~/.config/matugen/templates/polybar-colors.ini"
            output_path = "~/.config/polybar/colors.ini"

            [templates.rofi]
            input_path = '~/.config/matugen/templates/rofi-colors.rasi'
            output_path = '~/.config/rofi/shared/colors.rasi'

            [templates.dunst]
            input_path = '~/.config/matugen/templates/dunstrc'
            output_path = '~/.cache/matugen/dunstrc'
            post_hook = "dunstctl reload"

            [templates.alacritty]
            input_path = '~/.config/matugen/templates/alacritty-colors.toml'
            output_path = '~/.config/wal/templates/alacritty-colors.toml'

            [templates.i3colors]
            input_path = "~/.config/matugen/templates/i3lock-colors.sh"
            output_path = "~/.config/i3lock-colors.sh"
          ''}

          [templates.zathura]
          input_path = '~/.config/matugen/templates/zathura.toml'
          output_path = '~/.config/zathura/matugen'

          [templates.discord]
          input_path = '~/.config/matugen/templates/midnight-discord.css'
          output_path = '~/.config/Equicord/themes/midnight.css'

          [templates.vesktop]
          input_path = '~/.config/matugen/templates/midnight-discord.css'
          output_path = '~/.config/vesktop/themes/bidnight.css'

          [templates.yazi]
          input_path = '~/.config/matugen/templates/yazi.toml'
          output_path = '~/.config/yazi/theme.toml'

          ${lib.optionalString config.hyprland.enable ''
            [templates.hyprland]
            input_path = '~/.config/matugen/templates/hyprland.conf'
            output_path = '~/.config/hypr/colors.conf'
            post_hook = 'hyprctl reload'
          ''}

          [templates.fuzzel]
          input_path = '~/.config/matugen/templates/fuzzel.ini'
          output_path = '~/.config/fuzzel/fuzzel.ini'

          [templates.btop]
          input_path = '~/.config/matugen/templates/btop.theme'
          output_path = '~/.config/btop/themes/matugen.theme'

          [templates.gtk3]
          input_path = '~/.config/matugen/templates/colors.css'
          output_path = '~/.config/gtk-3.0/colors.css'

          [templates.gtk4]
          input_path = '~/.config/matugen/templates/colors.css'
          output_path = '~/.config/gtk-4.0/colors.css'

          [templates.neopywal]
          input_path = '~/.config/matugen/templates/neopywal.vim'
          output_path = '~/.cache/wal/colors-wal.vim'

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
