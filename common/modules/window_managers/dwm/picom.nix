<<<<<<< HEAD
{ config, ... }:
{
  services.picom = {
    enable = config.dwm.enable;
    backend = "glx";
    vSync = true;

    activeOpacity = 0.87;
    inactiveOpacity = 0.87;

    opacityRules = [
      "100:fullscreen"
      "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
    ];
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 4;
        size = 10;
      };
      blur-background = true;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'slop'"
        "class_g = 'dwm'"
        "_GTK_FRAME_EXTENTS@"
        "fullscreen"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];

      # xrender-sync-fence = true;
      use-damage = true;

      unredir-if-possible = true;

      detect-transient = true;
      detect-client-opacity = true;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;

      shadow = false;
      fading = false;
      animations = false;
    };
  };

  # systemd.user.services.picom.Install.wantedBy = lib.mkForce [ ];
  systemd.user.services.picom = {
    Unit = {
      ConditionEnvironment = "XDG_SESSION_TYPE=x11";
    };
  };
=======
homeManager:
{ config, lib, ... }:
let
  cfg = config.beeMods.windowManagers;
in
{
  config = lib.mkIf cfg.enable (
    lib.optionalAttrs homeManager {
      services.picom = {
        enable = true;
        backend = "glx";
        vSync = true;

        activeOpacity = if cfg.window.blur.enable then 0.82 else cfg.window.opacity.active;
        inactiveOpacity = if cfg.window.blur.enable then 0.82 else cfg.window.opacity.inactive;

        opacityRules = [
          "100:fullscreen"
          "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        ];
        settings = {
          blur = {
            method = "dual_kawase";
            strength = cfg.window.blur.strength;
            size = cfg.window.blur.size;
          };
          blur-background = cfg.window.blur.enable;
          blur-background-exclude = [
            "window_type = 'dock'"
            "window_type = 'desktop'"
            "class_g = 'slop'"
            "class_g = 'dwm'"
            "_GTK_FRAME_EXTENTS@"
            "fullscreen"
            "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
          ];

          # xrender-sync-fence = true;
          use-damage = true;

          unredir-if-possible = true;

          detect-transient = true;
          detect-client-opacity = true;
          mark-wmwin-focused = true;
          mark-ovredir-focused = true;
          detect-rounded-corners = true;

          shadow = cfg.shadow;
          fading = false;
          animations = cfg.animations;
        };
      };

      # systemd.user.services.picom.Install.wantedBy = lib.mkForce [ ];
      systemd.user.services.picom = {
        Unit = {
          ConditionEnvironment = "XDG_SESSION_TYPE=x11";
        };
      };
    }
  );
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
}
