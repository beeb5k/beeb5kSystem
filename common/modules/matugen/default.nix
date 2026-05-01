{
  homeManager,
  inputs,
  moduleNameSpace,
  ...
}:

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.${moduleNameSpace}.matugen;
  # link_zen = pkgs.writeShellScript "link_zen" ''
  #   export PROFILE_DIR=$(find ~/.config/zen/ -maxdepth 1 -type d -name "*.Default Profile" | head -n 1)
  #   mkdir -p "$PROFILE_DIR/chrome"
  #   ln -sf ~/.cache/wallust/userChrome.css "$PROFILE_DIR/chrome/userChrome.css"
  #   ln -sf ~/.config/userContent.css "$PROFILE_DIR/chrome/userContent.css"
  # '';
  update_gtkcolors = pkgs.writeShellScript "update_gtkcolors" ''
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
    sleep 0.1
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"

    systemctl --user restart xdg-desktop-portal-gtk
  '';
in
{
  imports = lib.optionals homeManager [ ./templates ];

  options.${moduleNameSpace}.matugen = {
    enable = lib.mkEnableOption "Enable Dynamic colors";
  };

  config = lib.mkIf cfg.enable (
    lib.optionalAttrs homeManager {
      xdg.configFile = {
        "matugen/config.toml" = {
          text =
            # toml
            ''
              [config]
              ${lib.optionalString config.programs.zathura.enable ''
                [templates.zathura]
                input_path = '~/.config/matugen/templates/zathura.toml'
                output_path = '~/.config/zathura/matugen'
              ''}

              ${lib.optionalString config.beeMods.windowManagers.mango.enable ''
                [templates.mango]
                input_path = '~/.config/matugen/templates/mango.conf'
                output_path = '~/.config/mango/mango-colors.conf'
                post_hook = 'mmsg -d reload_config'
              ''}

              ${lib.optionalString config.programs.btop.enable ''
                [templates.btop]
                input_path = '~/.config/matugen/templates/btop.theme'
                output_path = '~/.config/btop/themes/matugen.theme'
              ''}

              ${lib.optionalString config.programs.yazi.enable ''
                [templates.yazi]
                input_path = '~/.config/matugen/templates/yazi.toml'
                output_path = '~/.config/yazi/theme.toml'
              ''}

              ${lib.optionalString (config.beeMods.windowManagers.dwm.enable) ''
                [templates.Xresources]
                input_path = "~/.config/matugen/templates/colors-xresources"
                output_path = "~/.config/x11/matugen.Xresources"
              ''}

              ${lib.optionalString config.programs.vesktop.enable ''
                [templates.vesktop]
                input_path = "~/.config/matugen/templates/vesktop.css"
                output_path = "~/.config/vesktop/themes/system24.css"
              ''}

              ${lib.optionalString config.services.dunst.enable ''
                [templates.dunst]
                input_path = '~/.config/matugen/templates/dunstrc'
                output_path = '~/.config/dunst/dunstrc.d/colors.conf'
                post_hook = "dunstctl reload"
              ''}

              ${lib.optionalString
                (config.beeMods.terminal.default == "foot" || config.beeMods.terminal.default == "ghostty")
                ''
                  [templates.sequences]
                  input_path = '~/.config/matugen/templates/sequences'
                  output_path = '~/.config/sequences'
                  post_hook = "sh '${config.home.homeDirectory}/.config/sequences'"
                ''
              }
            '';
        };
      };
    }
  );
}
