{
  wayland.windowManager.hyprland.settings.general = {
    windowrulev2 = [
      "workspace 1,class:^(brave-browser|firefox|zen-beta)$"
      "workspace 2,class:^(foot)$"
      "workspace 3,class:^(vesktop)$"
      "workspace 4,class:^(Spotify)$"

      "suppressevent maximize,class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "opacity 0.80 override 0.80 override, class:.*,xwayland:0"
      "noblur, xwayland:1"

      # Picture-in-Picture
      "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$ "
      "size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$K"

      # Dialog windows – float+center these windows.
      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"
      "float, title:^(Open File)(.*)$"
      "float, title:^(Select a File)(.*)$"
      "float, title:^(Choose wallpaper)(.*)$"
      "float, title:^(Open Folder)(.*)$"
      "float, title:^(Save As)(.*)$"
      "float, title:^(Library)(.*)$"
      "float, title:^(File Upload)(.*)$"

      # No shadow for tiled windows
      "noshadow, floating:0"

      # Floating
      "float, class:^(blueberry\.py)$"
      "float, class:^(steam)$"
      "float, class:^(guifetch)$   # FlafyDev/guifetch"
      "float, class:^(pavucontrol)$"
      "size 45%, class:^(pavucontrol)$"
      "center, class:^(pavucontrol)$"
      "float, class:^(org.pulseaudio.pavucontrol)$"
      "size 45%, class:^(org.pulseaudio.pavucontrol)$"
      "center, class:^(org.pulseaudio.pavucontrol)$"
      "float, class:^(nm-connection-editor)$"
      "size 45%, class:^(nm-connection-editor)$"
      "center, class:^(nm-connection-editor)$"

      # Misc
      "center, class:^(imv)$"
      "float, class:^(imv)$"
    ];

    workspace = [
      "special:special, gapsout:30"
    ];

    layerrule = [
      "xray 1, .*"
      # "noanim, .*"
      "noanim, walker"
      "noanim, selection"
      "noanim, overview"
      "noanim, anyrun"
      "noanim, indicator.*"
      "noanim, osk"
      "noanim, hyprpicker"
      "noanim, noanim"
      "blur, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "blur, launcher"
      "ignorealpha 0.5, launcher"
      "blur, notifications"
      "ignorealpha 0.69, notifications"
      "blur, logout_dialog # wlogout"
    ];
  };
}
