{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    systemdTarget = "river-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "pgrep swaylock || ${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "pgrep swaylock || ${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "lock";
      }
    ];
  };
}
