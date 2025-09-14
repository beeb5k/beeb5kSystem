{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        # "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
        # "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
        # "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
        # "easeInOutCubic,0.65,0.05,0.36,1"
        # "standardDecel, 0, 0, 0, 1"
        "emphasizedDecel, 0.05, 0.7, 0.1, 1"
        "emphasizedAccel, 0.3, 0, 0.8, 0.15"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.52, 0.03, 0.72, 0.08"

        "easeOutQuint,0.23,1,0.32,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "windowsMove, 1, 3, emphasizedDecel, slide"
        "border, 1, 10, emphasizedDecel"
        "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
        "layersOut, 1, 2.4, menu_accel, popin 94%"
        "fadeLayersIn, 1, 0.5, menu_decel"
        "fadeLayersOut, 1, 2.7, menu_accel"
        "workspaces, 1, 7, menu_decel, slide"
        "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
        "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"

        "global,1,10,default"
        "windowsIn,1,4.1,easeOutQuint,popin 80%"
        "windowsOut,1,1.49,linear,popin 80%"
        "fadeIn,1,1.73,almostLinear"
        "fadeOut,1,1.46,almostLinear"
        "fade,1,3.03,quick"
      ];
    };
  };
}
