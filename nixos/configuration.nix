{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../modules/system/default.nix
    ./packages.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  systemd.services."NetworkManager-wait-online".enable = false;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = [ "hyprland;gtk" ];

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.enableRedistributableFirmware = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.openssh.enable = true;
  services.blueman.enable = true;
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  powerManagement = {
    enable = false;
    powertop.enable = false;
  };

  security.rtkit.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  # services.libinput.enable = true;
  users.users.beeb5k = {
    description = "Vivek Tiwari";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  networking.hostName = "dixos";
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # never chnage this.
}
