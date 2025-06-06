{ pkgs, ... }:
{
  xdg.dataFile."applications/foot-server.desktop".text = ''
    [Desktop Entry]
    Name=Foot Server
    Exec=${pkgs.foot}/bin/foot --server
    Type=Application
    NoDisplay=true
  '';

  xdg.dataFile."applications/footclient.desktop".text = ''
    [Desktop Entry]
    Name=Foot Client
    Exec=${pkgs.foot}/bin/footclient
    Type=Application
    NoDisplay=true
  '';

  # vs code
  xdg.dataFile."applications/code.desktop".text = ''
    [Desktop Entry]
    Actions=new-empty-window
    Categories=Utility;TextEditor;Development;IDE
    Comment=Code Editing. Redefined.
    Exec=code --ozone-platform=wayland %F
    GenericName=Text Editor
    Icon=vscode
    Keywords=vscode
    Name=Visual Studio Code
    StartupNotify=true
    StartupWMClass=Code
    Type=Application

    [Desktop Action new-empty-window]
    Exec=code --ozone-platform=wayland --new-window %F
    Icon=vscode
    Name=New Empty Window
  '';

  # vesktop
  xdg.dataFile."applications/vesktop.desktop".text = ''
    [Desktop Entry]
    Categories=Network;InstantMessaging;Chat
    Exec=vesktop --ozone-platform=wayland --enable-features=UseOzonePlatform %U
    GenericName=Internet Messenger
    Icon=vesktop
    Keywords=discord;vencord;electron;chat
    Name=Vesktop
    StartupWMClass=Vesktop
    Type=Application
  '';
}
