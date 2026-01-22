{
  config,
  lib,
  ...
}: {
  imports = [./templates];

  xdg.configFile = {
    "matugen/config.toml" = {
      enable = !config.programs.noctalia-shell.enable;
      text =
        # toml
        ''
          [config]
          ${lib.optionalString config.programs.alacritty.enable ''
            [templates.alacritty]
            input_path = '~/.config/matugen/templates/alacritty-colors.toml'
            output_path = '~/.config/wal/templates/alacritty-colors.toml'
          ''}

          ${lib.optionalString config.programs.foot.enable ''
            [templates.foot]
            input_path = '~/.config/matugen/templates/foot-colors.ini'
            output_path = '~/.config/wal/templates/foot-colors.ini'
          ''}

          ${lib.optionalString config.programs.zathura.enable ''
            [templates.zathura]
            input_path = '~/.config/matugen/templates/zathura.toml'
            output_path = '~/.config/zathura/matugen'
          ''}

          ${lib.optionalString config.programs.yazi.enable ''
            [templates.yazi]
            input_path = '~/.config/matugen/templates/yazi.toml'
            output_path = '~/.config/yazi/theme.toml'
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
