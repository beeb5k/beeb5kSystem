{
  systemState,
  user,
  hostname,
}:
{ pkgs, ... }:
let
  nvidia_icd = "${pkgs.vulkan-loader}/share/vulkan/icd.d/nvidia_icd.json";
  nvidia_layers = "${pkgs.vulkan-loader}/share/vulkan/explicit_layer.d";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # systemd.services."NetworkManager-wait-online".enable = false;

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
  services.upower.enable = true;
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
  security.polkit.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  services.libinput.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
    withUWSM = false;
  };

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    VK_ICD_FILENAMES = nvidia_icd;
    VK_LAYER_PATH = nvidia_layers;
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NVD_BACKEND = "direct";
  };

  networking.hostName = hostname;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = systemState; # check flake.nix
}
