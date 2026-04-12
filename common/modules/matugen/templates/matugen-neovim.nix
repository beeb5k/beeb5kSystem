{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.beeMods.beeVim.enable {
    xdg.configFile = {
      "matugen/templates/neovim.json" = {
        text =
          # json
          ''
            {
                "source_color": "{{colors.primary.default.hex}}",
                <* if {{ is_dark_mode }} *>
                "background": "{{colors.background.default.hex}}",
                <* else *>
                "background": "{{colors.surface_container.default.hex}}",
                <* endif *>
                "harmony": 0.5,
                "mode": "{{mode}}"
            }
          '';

      };
    };
  };
}
