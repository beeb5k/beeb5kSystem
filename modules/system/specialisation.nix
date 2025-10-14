{ lib, ... }:
{
  specialisation = {
    offload.configuration = {
      hardware.nvidia = {
        powerManagement.enable = lib.mkForce true;
        powerManagement.finegrained = lib.mkForce true;
        prime = {
          sync.enable = lib.mkForce false;
          offload.enable = lib.mkForce true;
          offload.enableOffloadCmd = lib.mkForce true;
          amdgpuBusId = "PCI:5:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      powerManagement = lib.mkForce {
        enable = true;
        powertop.enable = true;
      };

      networking.networkmanager.wifi.powersave = lib.mkForce true;

      environment.sessionVariables = lib.mkForce {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        GDK_BACKEND = "wayland,x11";
        GDK_SCALE = "1";
      };
    };
  };
}
