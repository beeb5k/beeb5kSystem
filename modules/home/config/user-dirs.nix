{
  xdg.terminal-exec.enable = true;
  xdg.terminal-exec.settings = {
    GNOME = ["foot.desktop"];
    default = ["foot.desktop"];
  };
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
