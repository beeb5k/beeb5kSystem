{user}: {
  pkgs,
  inputs,
  ...
}: {
  nix.settings = {
    trusted-users = ["@wheel"];
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

  services.kanata = {
    enable = true;
    keyboards.default = {
      # 1. Global Configuration
      extraDefCfg = "process-unmapped-keys yes";

      # 2. Layer Configuration
      config = ''
        ;; Define the physical keys on your keyboard that we want to modify
        (defsrc
          esc   caps  rctrl f1
        )

        ;; Define custom actions (Aliases)
        (defalias
          ;; The smart key:
          ;; - Tap: Sends Esc
          ;; - Hold: Sends Left Control
          ;; - "press": If you press another key while holding this, it triggers
          ;;            Left Control IMMEDIATELY (no lag). Perfect for Vim.
          capesc (tap-hold-press 200 200 esc lctrl)

          ;; Switches to toggle between layers
          game   (layer-switch gaming)
          base   (layer-switch base)
        )

        ;; 3. Base Layer (Typing Mode)
        ;; - Physical Esc     -> Caps Lock (Standard swap)
        ;; - Physical Caps    -> Esc (tap) / Ctrl (hold)
        ;; - Physical RCtrl   -> Switch to "Gaming Mode"
        ;; - Physical F1      -> Normal F1 behavior
        (deflayer base
          caps     @capesc  @game f1
        )

        ;; 4. Gaming Layer (Gaming Mode)
        ;; - Physical Esc     -> Caps Lock (keeps light toggle working)
        ;; - Physical Caps    -> Left Ctrl (Pure Ctrl! Safe for crouching)
        ;; - Physical RCtrl   -> Switch back to "Typing Mode"
        ;; - Physical F1      -> Escape (Your dedicated Pause button)
        (deflayer gaming
          caps     lctrl    @base esc
        )
      '';
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

  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.wifi.powersave = false;
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
  programs.nano.enable = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.upower.enable = false;
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
    android-tools
    tealdeer
  ];

  users.defaultUserShell = pkgs.fish;
}
