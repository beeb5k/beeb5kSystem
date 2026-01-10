{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod,RETURN,exec,$terminal"
      "$mainMod,T,exec,$terminal"
      "$mainMod,Q,killactive"
      "$mainMod ALT,M,exec,dms ipc call powermenu toggle"
      "$mainMod,E,exec,$fileManager"
      "$mainMod,SPACE,togglefloating"
      "$mainMod,A,exec, dms ipc call spotlight toggle"
      "$mainMod,V,exec,dms ipc call clipboard toggle"
      "$mainMod,comma, exec, dms ipc call settings toggle"
      "$mainMod,N, exec, dms ipc call notifications toggle"
      "$mainMod,TAB, exec, dms ipc call hypr toggleOverview"
      "$mainMod,Y, exec, dms ipc call dankdash wallpaper"
      "$mainMod,M, exec, dms ipc call processlist toggle"
      "$mainMod,slash,exec,dms ipc call notepad open"
      "$mainMod,B,exec,$browser"
      "$mainMod,P,pseudo"
      "$mainMod ALT,L,exec, dms ipc call lock lock"
      # "$mainMod,L,exec,hyprlock"
      "$mainMod,F,fullscreen,0"
      "$mainMod,D,fullscreen,1"
      "$mainMod SHIFT,E,togglesplit"
      "$mainMod,h,movefocus,l"
      "$mainMod,l,movefocus,r"
      "$mainMod,k,movefocus,u"
      "$mainMod,j,movefocus,d"
      "$mainMod,1,workspace,1"
      "$mainMod,2,workspace,2"
      "$mainMod,3,workspace,3"
      "$mainMod,4,workspace,4"
      "$mainMod,5,workspace,5"
      "$mainMod,6,workspace,6"
      "$mainMod,7,workspace,7"
      "$mainMod,8,workspace,8"
      "$mainMod,9,workspace,9"
      "$mainMod,0,workspace,10"
      "$mainMod SHIFT,1,movetoworkspace,1"
      "$mainMod SHIFT,2,movetoworkspace,2"
      "$mainMod SHIFT,3,movetoworkspace,3"
      "$mainMod SHIFT,4,movetoworkspace,4"
      "$mainMod SHIFT,5,movetoworkspace,5"
      "$mainMod SHIFT,6,movetoworkspace,6"
      "$mainMod SHIFT,7,movetoworkspace,7"
      "$mainMod SHIFT,8,movetoworkspace,8"
      "$mainMod SHIFT,9,movetoworkspace,9"
      "$mainMod SHIFT,0,movetoworkspace,10"
      "$mainMod,S,togglespecialworkspace"
      "$mainMod SHIFT,S,movetoworkspace,special"
      "$mainMod,mouse_down,workspace,e+1"
      "$mainMod,mouse_up,workspace,e-1"
      ",Print,exec,grimblast save output Pictures/Screenshots/shot_$(date +%s).png"
      "$mainMod,Print,exec,grimblast copy area"
    ];

    bindel = [
      ",XF86AudioRaiseVolume,exec,dms ipc call audio increment 3"
      ",XF86AudioLowerVolume,exec,dms ipc call audio decrement 3"
      ",XF86AudioMute,exec,dms ipc call audio mute"
      ",XF86AudioMicMute,exec,dms ipc call audio micmute"
      ",XF86MonBrightnessUp,exec,dms ipc call brightness increment 5 ''"
      ",XF86MonBrightnessDown,exec,dms ipc call brightness decrement 5 ''"
    ];

    bindl = [
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioPause,exec,playerctl play-pause"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
    ];

    bindm = [
      "$mainMod,mouse:272,movewindow"
      "$mainMod,mouse:273,resizewindow"
    ];
  };
}
