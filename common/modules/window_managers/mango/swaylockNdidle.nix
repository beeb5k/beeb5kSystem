{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mango;
  swaylock = "${pkgs.swaylock}/bin/swaylock -f -C ~/.config/swaylock/swaylock-colors";
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wlopm # For screen on/off
    ];

    services.swayidle = {
      enable = true;
      events = {
        "before-sleep" = swaylock;
        "lock" = "lock";
      };

      timeouts = [
        {
          timeout = 300;
          command = swaylock;
        }
        {
          timeout = 600;
          command = "${pkgs.wlopm}/bin/wlopm --off '*'";
          resumeCommand = "${pkgs.wlopm}/bin/wlopm --on '*'";
        }
        {
          timeout = 1800;
          command = "systemctl suspend";
        }
      ];
    };

    programs.swaylock.enable = true;
  };
}
