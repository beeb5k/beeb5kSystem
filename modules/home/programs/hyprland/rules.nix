{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "workspace 1, match:class ^(brave-browser|firefox|zen-beta|zen-twilight|zen)$"
      # "workspace 2, match:class ^(foot|footclient|alacritty|Alacritty|com.mitchellh.ghostty|)$"
      "workspace 3, match:class ^(vesktop|discord)$"
      "workspace 4, match:class ^(Spotify|steam)$"

      "suppress_event maximize, match:class .*"
      "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
      "no_blur on, match:xwayland 1"

      # Picture-in-Picture
      "float on, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "keep_aspect_ratio on, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "move 73% 72%, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$ "
      "size 25%, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "pin on, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"

      # Dialog windows – float+center
      "float on, center on, match:class ^(imv)$"
      "float on, center on, match:title ^(Open File)(.*)$"
      "float on, center on, match:title ^(Select a File)(.*)$"
      "float on, center on, match:title ^(Choose wallpaper)(.*)$"
      "float on, center on, match:title ^(Open Folder)(.*)$"
      "float on, center on, match:title ^(Save As)(.*)$"
      "float on, center on, match:title ^(Save Image)(.*)$"
      "float on, center on, match:title ^(Library)(.*)$"
      "float on, center on, match:title ^(File Upload)(.*)$"
      "float on, center on, match:class ^(xdg-desktop-portal-gtk)$"

      "float on, match:class ^(org.freedesktop.impl.portal.desktop.kde)$"

      # No shadow for tiled windows
      "no_shadow on, match:float 0"

      # Floating specific apps
      "float on, match:class ^(blueberry\.py)$"
      # "float on, match:class ^(steam)$"
      "float on, match:class ^(guifetch)$"

      # Pavucontrol (Float + Size + Center combined)
      "float on, size 45%, center on, match:class ^(pavucontrol)$"
      "float on, size 45%, center on, match:class ^(org.pulseaudio.pavucontrol)$"

      # Network Manager
      "float on, size 45%, center on, match:class ^(nm-connection-editor)$"

      "size 60% 60%, match:class ^(xdg-desktop-portal-gtk)$"

      # fix xwayland windows opening as float
      # "tile on, match:xwayland 1"
    ];

    workspace = [
      "special:special, gapsout:25"
    ];

    layerrule = [
      "xray 1, match:namespace .*"
      "no_anim on, match:namespace ^(quickshell)$"
      "no_anim on, match:namespace hyprpicker"
    ];
  };
}
