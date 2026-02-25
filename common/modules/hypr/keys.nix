{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, RETURN, exec, $terminal"
      "$mainMod, A, exec, rofi -show drun"
      "$mainMod, period, exec, rofi -show emoji -modi emoji"
      "ALT, F4, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
      "$mainMod, Y, exec, wall-picker"
      "$mainMod, F12, exec, gnome-calculator"
      "$mainMod, B, exec, zen"
      "$mainMod, E, exec, nautilus"

      "$mainMod, Q, killactive"
      "$mainMod, M, exit"
      "$mainMod, SPACE, togglefloating"
      "ALT, F, fullscreen, 0"
      "ALT, A, fullscreen, 1"

      "ALT, Z, togglespecialworkspace, scratchpad"
      "$mainMod, I, movetoworkspace, special:scratchpad"

      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"

      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"

      "$mainMod, Up, moveactive, 0 -50"
      "$mainMod, Down, moveactive, 0 50"
      "$mainMod, Left, moveactive, -50 0"
      "$mainMod, Right, moveactive, 50 0"

      "ALT, k, resizeactive, 0 -50"
      "ALT, j, resizeactive, 0 50"
      "ALT, h, resizeactive, -50 0"
      "ALT, l, resizeactive, 50 0"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"

      "ALT SHIFT, Left, focusmonitor, l"
      "ALT SHIFT, Right, focusmonitor, r"
      "$mainMod ALT, Left, movecurrentworkspacetomonitor, l"
      "$mainMod ALT, Right, movecurrentworkspacetomonitor, r"

      ", Print, exec, grimblast save output Pictures/Screenshots/shot_$(date +%s).png"
      "$mainMod, Print, exec, grimblast copy area"
    ];

    bindel = [
      ",XF86AudioRaiseVolume,exec,volume-control up"
      ",XF86AudioLowerVolume,exec,volume-control down"
      ",XF86AudioMute,exec,volume-control mute"
      ",XF86AudioMicMute,exec,mic-control toggle"
      ",XF86MonBrightnessUp,exec,brightness-control up"
      ",XF86MonBrightnessDown,exec,brightness-control down"
    ];

    bindl = [
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioPause,exec,playerctl play-pause"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
