{
  config,
  pkgs,
  ...
}:
let
  playSound = pkgs.writeShellScriptBin "play-notification-sound" ''
    ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message
  '';
in
{
  xdg.configFile."matugen/templates/dunstrc" = {
    text = ''
      [global]
      # --- Appearance ---
      font = "Lilex Nerd Font 11"
      corner_radius=7
      frame_width = 2
      markup = yes
      plain_text = no
      browser = zen --new-tab

      [play_sound]
      summary = "*"
      script = "${playSound}/bin/play-notification-sound"

      # --- Matugen Colors ---
      frame_color = "{{colors.primary.default.hex}}"
      separator_color = "{{colors.primary_container.default.hex}}"

      [urgency_low]
      background = "{{colors.surface.default.hex}}"
      foreground = "{{colors.on_surface.default.hex}}"

      [urgency_normal]
      background = "{{colors.surface.default.hex}}"
      foreground = "{{colors.on_surface.default.hex}}"

      [urgency_critical]
      background = "{{colors.error_container.default.hex}}"
      foreground = "{{colors.on_error_container.default.hex}}"
      frame_color = "{{colors.error.default.hex}}"
    '';
  };
}
