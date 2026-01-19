{config, ...}: {
  services.picom = {
    enable = config.bspwm.enable;

    backend = "egl";
    vSync = true;

    settings = {
      use-damage = true;
      unredir-if-possible = true;
      detect-transient = true;
      detect-client-opacity = true;

      vsync-use-glfinish = false;
      dbe = false;

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;

      shadow = false;
      fade = false;
      blur-method = "none";
      animations = false;

      inactive-opacity = 1.0;
      active-opacity = 1.0;
      frame-opacity = 1.0;

      detect-rounded-corners = true;
      resize-damage = 1;
    };
  };
}
