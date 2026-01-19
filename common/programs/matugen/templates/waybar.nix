{
  xdg.configFile = {
    "matugen/templates/waybar-colors.css" = {
      enable = true;
      text =
        # css
        ''
          @define-color background {{colors.surface.default.hex}};
          @define-color background-alt {{colors.surface_container.default.hex}};
          @define-color foreground {{colors.on_surface.default.hex}};
          @define-color primary {{colors.primary.default.hex}};
          @define-color secondary {{colors.secondary.default.hex}};
          @define-color alert {{colors.error.default.hex}};
          @define-color disabled {{colors.outline.default.hex}};
        '';
    };
  };
}
