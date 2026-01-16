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
    ../../modules/system
    inputs.dms.nixosModules.greeter
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Asia/Kolkata";

  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      LidSwitchIgnoreInhibit = "no";
    };
  };

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
    flake = "/home/${user}/beeb5kSystem/";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.enableRedistributableFirmware = true;
  programs.dconf.enable = true;
  programs.dank-material-shell.greeter = {
    enable = false;
    compositor.name = "hyprland";
    configHome = "/home/${user}";
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

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

  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.earlyoom.enable = false;
  services.fwupd.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = false;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.openssh.enable = true;
  services.upower.enable = false;
  services.blueman.enable = false;
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
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
    enable = false;
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
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
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
    nerd-fonts.lilex
    ibm-plex
  ];

  programs.mtr.enable = true;
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = false;
    withUWSM = false;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 20;
    xkb = {
      layout = "us";
      variant = "";
    };
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
      # mouse.naturalScrolling = false; # Optional for mouse
    };

    windowManager.bspwm.enable = true;
  };

  environment.sessionVariables = {
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm";
    # LIBVA_DRIVER_NAME = "nvidia";
    # NVD_BACKEND = "direct";
    # MESA_DEVICE_SELECTION = "NVIDIA";
    # __NV_PRIME_RENDER_OFFLOAD = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # __VK_LAYER_NV_optimus = "prefer";

    # NIXOS_OZONE_WL = 1;
    # ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    # QT_QPA_PLATFORM = "wayland;xcb";
    # SDL_VIDEODRIVER = "wayland";
    # XDG_SESSION_TYPE = "wayland";
    # GDK_BACKEND = "wayland,x11";
    # GDK_SCALE = 1;
  };

  networking.hostName = hostname;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = systemState; # check flake.nix
}
