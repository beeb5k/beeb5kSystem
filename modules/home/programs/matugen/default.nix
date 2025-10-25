{
  imports = [ ./templates ];

  xdg.configFile = {
    "matugen/config.toml" = {
      enable = true;
      text =
        # toml
        ''
          [config]
          version_check = true

          [config.wallpaper]
          command = 'swww'
          arguments = ['img', '--transition-step', '100', '--transition-fps', '120', '--transition-type', 'grow',  '--transition-angle', '30' ,'--transition-duration', '1']

          [templates.zathura]
          input_path = '~/.config/matugen/templates/zathura.toml'
          output_path = '~/.config/zathura/matugen'

          [templates.gtk3]
          input_path = '~/.config/matugen/templates/gtk.css'
          output_path = '~/.config/gtk-3.0/colors.css'

          [templates.gtk4]
          input_path = '~/.config/matugen/templates/gtk.css'
          output_path = '~/.config/gtk-4.0/colors.css'

          [templates.discord]
          input_path = '~/.config/matugen/templates/midnight-discord.css'
          output_path = '~/.config/Equicord/themes/midnight.css'

          [templates.yazi]
          input_path = '~/.config/matugen/templates/yazi.toml'
          output_path = '~/.config/yazi/theme.toml'

          [templates.hyprland]
          input_path = '~/.config/matugen/templates/hyprland.conf'
          output_path = '~/.config/hypr/colors.conf'
          post_hook = 'hyprctl reload'

          [templates.starship]
          input_path = '~/.config/matugen/templates/starship.toml'
          output_path = '~/.config/starship.toml'

          [templates.sequences]
          input_path = '~/.config/matugen/templates/sequence.sh'
          output_path = '~/.config/sequences.sh'
          post_hook = 'terminal-change-color'

          [templates.fuzzel]
          input_path = '~/.config/matugen/templates/fuzzel.ini'
          output_path = '~/.config/fuzzel/fuzzel.ini'

          # [templates.pywalfox]
          # input_path = '~/.config/matugen/templates/pywalfox.json'
          # output_path = '~/.cache/wal/colors.json'
          # post_hook = 'pywalfox update'

          [templates.btop]
          input_path = '~/.config/matugen/templates/btop.theme'
          output_path = '~/.config/btop/themes/matugen.theme'

          [templates.neopywal]
          input_path = '~/.config/matugen/templates/neopywal.vim'
          output_path = '~/.cache/wal/colors-wal.vim'

          [templates.firefox]
          input_path = '~/.config/matugen/templates/firefox.css'
          output_path = '~/.mozilla/firefox/default/chrome/theme-material-blue.css'
        '';
    };
  };
}
