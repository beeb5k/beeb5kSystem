{
  config,
  pkgs,
  ...
}:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      libva-vdpau-driver
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    vulkan-validation-layers
    libva-utils
    vulkan-tools
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # open source drivers
    nvidiaSettings = false;

    prime = {
      sync.enable = true; # NVIDIA drives display
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
