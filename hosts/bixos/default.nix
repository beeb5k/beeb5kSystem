{
  systemState,
  user,
  hostname,
}:
{ pkgs, config, ... }:
let
  nvidia_icd = "${config.hardware.nvidia.package}/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  nvidia_layers = "${config.hardware.nvidia.package}/share/vulkan/implicit_layer.d";
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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = "/home/beeb5k/beeb5kSystem/";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.enableRedistributableFirmware = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.fwupd.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = false;
  services.printing.enable = false;
  services.openssh.enable = true;
  services.upower.enable = false;
  services.blueman.enable = true;
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = false;
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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  # security.pam.services.sddm.enableGnomeKeyring = true;
  services.libinput.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  programs.mtr.enable = true;
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm";
    # LIBVA_DRIVER_NAME = "nvidia";
    # NVD_BACKEND = "direct";
    # VK_ICD_FILENAMES = nvidia_icd;
    # VK_LAYER_PATH = nvidia_layers;
    # MESA_DEVICE_SELECTION = "NVIDIA";
    # __NV_PRIME_RENDER_OFFLOAD = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = 1;
  };

  networking.hostName = hostname;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = systemState; # check flake.nix
}
