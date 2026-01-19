{
  xdg.configFile = {
    "matugen/templates/polybar-colors.ini" = {
      enable = true;
      text =
        # ini
        ''
          [colors]
          background = {{colors.surface.default.hex}}
          background-alt = {{colors.surface_container.default.hex}}
          foreground = {{colors.on_surface.default.hex}}
          primary = {{colors.primary.default.hex}}
          secondary = {{colors.secondary.default.hex}}
          alert = {{colors.error.default.hex}}
          disabled = {{colors.outline.default.hex}}
        '';
    };
  };
}
