{
  xdg.configFile = {
    "matugen/templates/bspwm-colors.sh" = {
      enable = true;
      text =
        # sh
        ''
          #!/bin/sh
          export COLOR_FOCUSED="{{colors.tertiary_fixed_dim.default.hex}}"
          export COLOR_NORMAL= "{{colors.outline.default.hex}}"
        '';
    };
  };
}
