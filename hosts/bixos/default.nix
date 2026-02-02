{
  systemState,
  user,
  hostname,
}: {
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ../system.nix {inherit user;})
    inputs.self.nixosModules.mango
    inputs.self.nixosModules.dwm
    # inputs.self.nixosModules.specialisation
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.dconf.enable = true;
  documentation.man.man-db.enable = false;
  documentation.man.mandoc.enable = true;

  mango.enable = true;

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

  xdg.portal = lib.mkForce {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-luminous
    ];
    config = {
      common = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };
      mango = {
        "org.freedesktop.impl.portal.ScreenCast" = ["luminous"];
        "org.freedesktop.impl.portal.Screenshot" = ["luminous"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["luminous"];
      };
    };
  };

  programs.gamemode.enable = true;
  programs.gamescope = {
    capSysNice = true;
    enable = true;
  };
  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
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
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    # SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = 1;
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
