{
  xdg.dataFile."applications/foot-server.desktop".text = ''
    [Desktop Entry]
    Name=Foot Server
    Exec=foot --server
    Type=Application
    NoDisplay=true
  '';

  xdg.dataFile."applications/footclient.desktop".text = ''
    [Desktop Entry]
    Name=Foot Client
    Exec=footclient
    Type=Application
    NoDisplay=true
  '';

  xdg.desktopEntries = {
    vesktop = {
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      exec = "vesktop --ozone-platform=wayland --enable-features=UseOzonePlatform %U";
      genericName = "Internet Messenger";
      icon = "vesktop";
      name = "Vesktop";
      type = "Application";
      # prefersNonDefaultGPU = true;
      settings = {
        Keywords = "discord;vencord;electron;chat";
        StartupWMClass = "Vesktop";
      };
    };
  };
}
