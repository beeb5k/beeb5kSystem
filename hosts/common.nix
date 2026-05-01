{ user }:
{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings = {
    trusted-users = [ "@wheel" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = "/home/${user}/.config/beeSystems";
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 50;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      splashImage = null;
      theme = null;
      configurationLimit = 4;
    };
  };

  services.kanata = {
    enable = true;
    keyboards.default = {
      extraDefCfg = "process-unmapped-keys yes";

      config = ''
        (defsrc
          esc   caps  rctrl f1
        )

        (defalias
          capesc (tap-hold-press 200 200 esc lctrl)

          game   (layer-switch gaming)
          base   (layer-switch base)
        )

        (deflayer base
          caps     @capesc  @game f1
        )

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
      load = true;
      save = true;
    };
  };

  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  nixpkgs.config.allowUnfree = true;
  nix.registry.${user}.flake = inputs.self;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

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
    jack.enable = false;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
  };

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    ioskeley-input
    nerd-fonts.symbols-only
    # ioskeley-mono
    # maple-mono.NF
    # nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "IosevkaInput"
    "Symbols Nerd Font"
  ];

  programs.fish.enable = true;
  programs.nano.enable = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/home/bee/.config/sops/age/keys.txt";
    secrets.gpg_private_key = {
      owner = user;
      mode = "0400";
    };
  };

  systemd.services.import-gpg-key = {
    description = "Import GPG key from sops secret";
    wantedBy = [ "multi-user.target" ];
    after = [ "sops-nix.service" ];
    wants = [ "sops-nix.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = user;
    };
    path = [
      pkgs.gnupg
      pkgs.gawk
    ];
    script = ''
      GPG_KEY="/run/secrets/gpg_private_key"
      if [ -f "$GPG_KEY" ]; then
        gpg --batch --import "$GPG_KEY" || true
        KEY_FP=$(gpg --batch --with-colons --list-secret-keys | awk -F: '/^fpr:/{print $10; exit}')
        if [ -n "$KEY_FP" ]; then
          echo "$KEY_FP:6:" | gpg --batch --import-ownertrust || true
        fi
      fi
    '';
  };

  services.upower.enable = true;
  services.earlyoom.enable = false;
  services.fwupd.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.openssh.enable = false;
  services.dbus.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    android-tools
    playerctl
    pciutils
    imagemagick
    sops
    fd
    ripgrep
    bat
  ];

  users.defaultUserShell = pkgs.fish;
}
