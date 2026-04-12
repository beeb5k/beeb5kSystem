{
  lib,
  config,
}:
let
  cfg = config.beeMods.terminal;
in
{
  config = lib.mkIf cfg.ghostty {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = lib.optionalString config.beeMods.matugen.enable "matugen";

        font-family = cfg.font.family;
        font-size = cfg.font.size;
        # alpha-blending = "linear";
        window-padding-x = cfg.window.padding-x;
        window-padding-y = cfg.window.padding-y;
        gtk-titlebar = false;
        gtk-single-instance = true;
        gtk-tabs-location = "bottom";
        gtk-wide-tabs = false;
        resize-overlay = "never";
        copy-on-select = false;
        confirm-close-surface = false;
        mouse-hide-while-typing = true;
        window-decoration = "none";
        window-inherit-working-directory = false;
        app-notifications = [
          "no-clipboard-copy"
          "no-config-reload"
        ];
      };
    };
  };
}
