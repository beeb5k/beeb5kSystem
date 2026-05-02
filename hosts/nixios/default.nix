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
  imports = with inputs.self.nixosModules; [
    ./hardware-configuration.nix
    (import ../common.nix { inherit user; })
    beeMods
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.dconf.enable = true;

  beeMods = {
    windowManagers = {
      mango.enable = false;
      hyprland.enable = true;
      dwm.enable = false;
    };
  };

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
        "org.freedesktop.impl.portal.Inhibit" = [ "none" ];
      };
      hyrpland = {
        default = [
          "hyrland"
          "gtk"
        ];
      };
    };
  };

  programs.gamemode.enable = config.programs.steam.enable;
  programs.gamescope = {
    enable = config.programs.steam.enable;
    # capSysNice = true;
  };
  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
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
    mangohud
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

      package = config.boot.kernelPackages.nvidiaPackages.latest; # or stable
    };
  };

  system.stateVersion = systemState; # check flake.nix
}
