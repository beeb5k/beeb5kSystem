{config, ...}: {
  imports = [./templates];

  xdg.configFile = {
    "matugen/config.toml" = {
      enable = config.hyprland.enable;
      text =
        # toml
        ''
          [config]
          version_check = true

          [templates.zathura]
          input_path = '~/.config/matugen/templates/zathura.toml'
          output_path = '~/.config/zathura/matugen'

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

          [templates.fuzzel]
          input_path = '~/.config/matugen/templates/fuzzel.ini'
          output_path = '~/.config/fuzzel/fuzzel.ini'

          [templates.btop]
          input_path = '~/.config/matugen/templates/btop.theme'
          output_path = '~/.config/btop/themes/matugen.theme'

          [templates.neopywal]
          input_path = '~/.config/matugen/templates/neopywal.vim'
          output_path = '~/.cache/wal/colors-wal.vim'

          [templates.firefox]
          input_path = '~/.config/matugen/templates/firefox.css'
          output_path = '~/.mozilla/firefox/default/chrome/theme-material-blue.css'

          [templates.zed]
          input_path = '~/.config/matugen/templates/zed.json'
          output_path = '~/.config/zed/themes/matugen.json'
        '';
    };
  };
}
