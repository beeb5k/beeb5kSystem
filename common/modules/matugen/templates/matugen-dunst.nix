{
  xdg.configFile."matugen/templates/dunstrc" = {
    text = ''
      [global]
      frame_color = "{{colors.primary.default.hex}}"
      separator_color = "{{colors.primary_container.default.hex}}"
      foreground = "{{colors.on_surface.default.hex}}"
      highlight = "{{colors.primary.default.hex}}"
      <* if {{ is_dark_mode }} *>
      background = "{{colors.surface.default.hex}}"
      <* else *>
      background = "{{colors.surface_container.default.hex}}"
      <* endif *>

      [urgency_critical]
      background = "{{colors.error_container.default.hex}}"
      foreground = "{{colors.on_error_container.default.hex}}"
      frame_color = "{{colors.error.default.hex}}"
      highlight = "{{colors.error.default.hex}}"
    '';
  };
}
