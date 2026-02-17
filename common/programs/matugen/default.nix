{
  config,
  lib,
  pkgs,
  ...
}: let
  link_zen = pkgs.writeShellScript "link_zen" ''
    export PROFILE_DIR=$(find ~/.config/zen/ -maxdepth 1 -type d -name "*.Default Profile" | head -n 1)
    mkdir -p "$PROFILE_DIR/chrome"
    ln -sf ~/.cache/wallust/userChrome.css "$PROFILE_DIR/chrome/userChrome.css"
  '';
  update_gtkcolors = pkgs.writeShellScript "update_gtkcolors" ''
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
    sleep 0.1
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"

    systemctl --user restart xdg-desktop-portal-gtk
  '';
in {
  imports = [./templates];

  programs.wallust = {
    enable = true;
    settings = {
      backend = "kmeans";
      # color_space = "lch";
      color_space = "labmixed";
      palette = "dark16";
      fallback_generator = "interpolate";
      threshold = 11;
      check_contrast = true;
      templates = {
        foot = {
          template = "foot-colors.ini";
          target = "~/.config/foot/colors.ini";
        };
        alacritty = {
          template = "alacritty-colors.toml";
          target = "~/.config/alacritty/colors.toml";
        };
        ghostty = {
          template = "ghostty-colors.conf";
          target = "~/.config/ghostty/colors.conf";
        };
        zen = {
          template = "userChrome.css";
          target = "~/.cache/wallust/userChrome.css";
        };
        st = {
          template = "st";
          target = "~/.config/x11/matugen_st.Xresources";
        };
      };
    };
  };

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
            output_path = '~/.config/wallust/templates/alacritty-colors.toml'
          ''}

          ${lib.optionalString config.programs.foot.enable ''
            [templates.foot]
            input_path = '~/.config/matugen/templates/foot-colors.ini'
            output_path = '~/.config/wallust/templates/foot-colors.ini'
          ''}

          ${lib.optionalString config.programs.ghostty.enable ''
            [templates.ghostty]
            input_path = '~/.config/matugen/templates/ghostty.conf'
            output_path = '~/.config/wallust/templates/ghostty-colors.conf'
          ''}

          ${lib.optionalString config.programs.zathura.enable ''
            [templates.zathura]
            input_path = '~/.config/matugen/templates/zathura.toml'
            output_path = '~/.config/zathura/matugen'
          ''}

          ${lib.optionalString config.programs.swaylock.enable ''
            [templates.swaylock]
            input_path = '~/.config/matugen/templates/swaylock-colors'
            output_path = '~/.config/swaylock/swaylock-colors'
          ''}

          ${lib.optionalString config.mango.enable ''
            [templates.mango]
            input_path = '~/.config/matugen/templates/mango.conf'
            output_path = '~/.config/mango/mango-colors.conf'
          ''}

          ${lib.optionalString config.programs.btop.enable ''
            [templates.btop]
            input_path = '~/.config/matugen/templates/btop.theme'
            output_path = '~/.config/btop/themes/matugen.theme'
          ''}


          ${lib.optionalString config.dwm.enable ''
            [templates.st]
            input_path = "~/.config/matugen/templates/st"
            output_path = "~/.config/wallust/templates/st"
          ''}


          ${lib.optionalString config.programs.vesktop.enable ''
            [templates.discord]
            input_path = "~/.config/matugen/templates/discord.css"
            output_path = "~/.config/vesktop/themes/midnight.css"
          ''}

            [templates.dunst]
            input_path = '~/.config/matugen/templates/dunstrc'
            output_path = '~/.config/dunst/dunstrc'
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
            post_hook = "${update_gtkcolors}"
          ''}

            [templates.zed]
            input_path = '~/.config/matugen/templates/zed.json'
            output_path = '~/.config/zed/themes/matugen.json'

            [templates.zen]
            input_path = '~/.config/matugen/templates/zen.css'
            output_path = '~/.config/wallust/templates/userChrome.css'
            post_hook = "${link_zen}"
        '';
    };
  };
}
