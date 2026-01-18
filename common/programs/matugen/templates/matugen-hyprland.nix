{
  xdg.configFile = {
    "matugen/templates/hyprland.conf" = {
      enable = true;
      text =
        # conf
        ''
          $image = {{image}}
          <* for name, value in colors *>
          $_{{name}} = rgba({{value.default.hex_stripped}}ff)
          <* endfor *>
        '';
    };
  };
}
