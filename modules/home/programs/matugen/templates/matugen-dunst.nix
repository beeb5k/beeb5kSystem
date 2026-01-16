{
  config,
  pkgs,
  ...
}: let
  # 1. Create the sound player script
  # You can replace 'canberra-gtk-play -i message' with 'paplay /path/to/sound.wav'
  playSound = pkgs.writeShellScriptBin "play-notification-sound" ''
    ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message
  '';
in {
  xdg.configFile."matugen/templates/dunstrc" = {
    # 2. Add the 'script' line to each urgency section
    text = ''
      [global]
      # --- Appearance ---
      font = "Lilex Nerd Font 11"

      # --- Matugen Colors ---
      frame_color = "{{colors.primary.default.hex}}"
      separator_color = "{{colors.primary_container.default.hex}}"

      [urgency_low]
      background = "{{colors.surface.default.hex}}"
      foreground = "{{colors.on_surface.default.hex}}"
      script = "${playSound}/bin/play-notification-sound"

      [urgency_normal]
      background = "{{colors.surface.default.hex}}"
      foreground = "{{colors.on_surface.default.hex}}"
      script = "${playSound}/bin/play-notification-sound"

      [urgency_critical]
      background = "{{colors.error_container.default.hex}}"
      foreground = "{{colors.on_error_container.default.hex}}"
      frame_color = "{{colors.error.default.hex}}"
      script = "${playSound}/bin/play-notification-sound"
    '';
  };
}
