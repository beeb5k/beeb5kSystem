{user}: {pkgs, ...}: {
  nix.settings = {
    trusted-users = ["@wheel"];
    extra-trusted-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = "/home/${user}/beeb5kSystem/";
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 50;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 4;
      theme = pkgs.fetchFromGitHub {
        owner = "shvchk";
        repo = "fallout-grub-theme";
        rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
        sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
      };
    };
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
  };

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

  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true;
      load = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = false;

  hardware.enableRedistributableFirmware = true;

  services.libinput.enable = true;
  services.libinput.touchpad = {
    naturalScrolling = true;
    disableWhileTyping = true;
  };

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

  security.rtkit.enable = true;
  security.polkit.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.lilex
    ibm-plex
  ];
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.earlyoom.enable = false;
  services.fwupd.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.openssh.enable = true;
  services.dbus.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    vesktop
    android-tools
  ];

  users.defaultUserShell = pkgs.fish;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
