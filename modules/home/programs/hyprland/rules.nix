{
  wayland.windowManager.hyprland.settings.general = {
    windowrulev2 = [
      "workspace 1,class:^(brave-browser|firefox|zen-beta|zen-twilight)$"
      # "workspace 2,class:^(foot|footclient|alacritty|Alacritty|com.mitchellh.ghostty|)$"
      "workspace 3,class:^(vesktop)$"
      "workspace 4,class:^(Spotify)$"

      "suppressevent maximize,class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "noblur, xwayland:1"

      # Picture-in-Picture
      "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$ "
      "size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$K"

      # Dialog windows – float+center these windows.
      "center, class:^(imv)$"
      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Save Image)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"
      "float, title:^(Open File)(.*)$"
      "float, title:^(Select a File)(.*)$"
      "float, title:^(Choose wallpaper)(.*)$"
      "float, title:^(Open Folder)(.*)$"
      "float, title:^(Save As)(.*)$"
      "float, title:^(Library)(.*)$"
      "float, title:^(File Upload)(.*)$"
      "float, class:^(org.freedesktop.impl.portal.desktop.kde)$"
      "float, class:^(imv)$"

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
    ];

    workspace = [
      "special:special, gapsout:25"
    ];

    layerrule = [
      "xray 1, .*"
      "noanim, ^(quickshell)$"
      "noanim, hyprpicker"
      # "animation slide, quickshell:bar"
      # "animation fade, quickshell:screenCorners"
      # "animation slide right, quickshell:sidebarRight"
      # "animation slide left, quickshell:sidebarLeft"
      # "animation slide bottom, quickshell:osk"
      # "animation slide bottom, quickshell:dock"
      # "blur, quickshell:session"
      # "noanim, quickshell:session"
      # "ignorealpha 0, quickshell:session"
      # "animation fade, quickshell:notificationPopup"
      # "blur, quickshell:backgroundWidgets"
      # "ignorealpha 0.05, quickshell:backgroundWidgets"
      # "noanim, quickshell:screenshot"
      # "animation popin 120%, quickshell:screenCorners"
    ];
  };
}
