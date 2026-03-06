{
  xdg.configFile."matugen/templates/waybar.css" = {
    text = ''
      @define-color bg_panel alpha({{colors.surface.default.hex}}, 0.9);
      @define-color bg_base transparent;
      @define-color border_color {{colors.primary.default.hex}};
      @define-color text_main {{colors.primary.default.hex}};
      @define-color text_muted {{colors.primary.default.hex}};
      @define-color text_dim {{colors.primary.default.hex}};
      @define-color text_accent {{colors.primary.default.hex}};
      @define-color text_dark {{colors.surface_container_highest.default.hex}};
      @define-color alert_urgent {{colors.error.default.hex}};
      @define-color alert_minimized {{colors.error_container.default.hex}};
      @define-color alert_critical {{colors.on_error_container.default.hex}};
    '';
  };
}
