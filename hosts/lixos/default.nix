{
  systemState,
  user,
  hostname,
}:
{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    (import ../system.nix { inherit user; })
    inputs.self.nixosModules.mango
    inputs.self.nixosModules.dwm
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.dconf.enable = true;
  documentation.man.man-db.enable = false;
  documentation.man.mandoc.enable = true;
  mango.enable = true;
  dwm.enable = true;
  security.pam.services.swaylock = { };

  xdg.portal = lib.mkForce {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      mango = {
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };

  programs.gamemode.enable = config.programs.steam.enable;
  programs.gamescope = {
    enable = config.programs.steam.enable;
    capSysNice = true;
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

  environment.sessionVariables = { };

  networking.hostName = hostname;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    libva-utils
    vulkan-tools
    pciutils
    direnv
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
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

  # specialisation = {
  #   xorg.configuration = {
  #     mango.enable = lib.mkForce false;
  #     dwm.enable = lib.mkForce true;
  #     environment.sessionVariables = {
  #       NIXOS_OZONE_WL = lib.mkForce "0";
  #       ELECTRON_OZONE_PLATFORM_HINT = lib.mkForce "x11";
  #       QT_QPA_PLATFORM = lib.mkForce "xcb";
  #       GDK_BACKEND = lib.mkForce "x11";
  #       XDG_SESSION_TYPE = lib.mkForce "x11";
  #     };
  #     home-manager.users.${user} = {
  #       mango.enable = lib.mkForce false;
  #       dwm.enable = lib.mkForce true;
  #     };
  #   };
  # };
  #
  system.stateVersion = systemState; # check flake.nix
}
