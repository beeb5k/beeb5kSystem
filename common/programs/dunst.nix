{
  lib,
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
  services.dunst = {
    enable = false;
    settings = {
      global = {
        font = "monospace 11";
        corner_radius = 0;
        frame_width = 2;
        markup = "yes";
        browser = "zen --new-tab";

        origin = "top-right";
        offset = "(10, 25)";
      };
      urgency_low = {
        timeout = 3;
      };

      urgency_normal = {
        timeout = 5;
      };

      urgency_critical = {
        timeout = 0;
      };
      play_sound = {
        summary = "*";
        script = "${playSound}/bin/play-notification-sound";
      };
    };
  };
}
