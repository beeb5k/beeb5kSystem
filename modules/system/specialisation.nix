{lib, ...}: {
  specialisation = {
    power_save.configuration = {
      powerManagement = lib.mkForce {
        enable = true;
        powertop.enable = true;
      };
      networking.networkmanager.wifi.powersave = lib.mkForce true;

      services.xserver.videoDrivers = lib.mkForce ["amdgpu"];

      hardware.nvidia = lib.mkForce {
        modesetting.enable = false;
        powerManagement.enable = false;
        open = false;
        nvidiaSettings = false;
        prime = {
          offload.enable = false;
          sync.enable = false;
        };
      };

      boot.blacklistedKernelModules = lib.mkForce [
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
      ];
    };
  };
}
