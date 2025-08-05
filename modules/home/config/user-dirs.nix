{
  xdg.terminal-exec.enable = true;
  xdg.terminal-exec.settings = {
    GNOME = [ "foot.desktop" ];
    default = [ "foot.desktop" ];
  };
  xdg.userDirs = {
    enable = true;
    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
  };
}
