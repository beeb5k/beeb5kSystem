{
  xdg.configFile = {
    "matugen/config.toml" = {
      enable = true;
      text =
        # toml
        ''
          [config]
          version_check = true

          [config.wallpaper]
          command = "swww"
          arguments = ["img", "--transition-step", "100", "--transition-fps", "120", "--transition-type", "grow",  "--transition-angle", "30" ,"--transition-duration", "1"]

          [templates.zathura]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-zathura.toml'
          output_path = '~/.config/zathura/matugen'

          [templates.gtk3]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-gtk-colors.css'
          output_path = '~/.config/gtk-3.0/colors.css'

          [templates.gtk4]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-gtk-colors.css'
          output_path = '~/.config/gtk-4.0/colors.css'

          [templates.discord]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-discord.css'
          output_path = '~/.config/vesktop/themes/midnight-dis.css'

          [templates.yazi]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-yazi.toml'
          output_path = '~/.config/yazi/theme.toml'

          [templates.hyprland]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-colors.conf'
          output_path = '~/.config/hypr/colors.conf'
          post_hook = 'hyprctl reload'

          [templates.starship]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-starship.toml'
          output_path = '~/.config/starship.toml'

          [templates.qt5ct]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-qtct.conf'
          output_path = '~/.config/qt5ct/colors/matugen.conf'

          [templates.qt6ct]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-qtct.conf'
          output_path = '~/.config/qt6ct/colors/matugen.conf'

          [templates.sequences]
          input_path = '~/beeb5kSystem/modules/home/programs/matugen/templates/sequences.sh'
          output_path = '~/.config/sequences.sh'
          post_hook = "terminal-change-color"

          [templates.anyrun]
          input_path = "~/beeb5kSystem/modules/home/programs/matugen/templates/matugen-anyrun.css"
          output_path = "~/.config/anyrun/style.css"
        '';
    };
  };
}
