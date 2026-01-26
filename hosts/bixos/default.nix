{
  systemState,
  user,
  hostname,
}: {
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ../system.nix {inherit user;})
    inputs.self.nixosModules.mango
    inputs.self.nixosModules.bspwm
    inputs.self.nixosModules.specialisation
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.dconf.enable = true;
  documentation.man.man-db.enable = false;
  documentation.man.mandoc.enable = true;

  mango.enable = true;
  bspwm.enable = false;

  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  environment.sessionVariables = {
    # NIXOS_OZONE_WL = 1;
  };

  networking.hostName = hostname;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    vulkan-validation-layers
    libva-utils
    vulkan-tools
    clang
  ];

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = false;

      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        offload.offloadCmdMainProgram = "prime-run";
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:5:0:0";
      };

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  system.stateVersion = systemState; # check flake.nix
}
