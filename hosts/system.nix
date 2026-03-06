{ user }:
{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  ioskeley-mono = pkgs.iosevka.override {
    set = "IoskeleyMono";
    privateBuildPlan = {
      family = "Ioskeley Mono";
      spacing = "normal";
      serifs = "sans";
      noCvSs = true;
      exportGlyphNames = false;

      variants.design = {
        one = "no-base";
        two = "straight-neck-serifless";
        three = "flat-top-serifless";
        four = "semi-open-serifless";
        five = "oblique-flat-serifless";
        six = "open-contour";
        seven = "straight-serifless";
        eight = "two-circles";
        nine = "open-contour";
        zero = "dotted";
        capital-a = "straight-serifless";
        capital-b = "standard-serifless";
        capital-c = "bilateral-inward-serifed";
        capital-d = "standard-serifless";
        capital-e = "serifless";
        capital-f = "serifless";
        capital-g = "toothless-corner-inward-serifed-hooked";
        capital-h = "serifless";
        capital-i = "serifed";
        capital-j = "serifless";
        capital-k = "symmetric-touching-serifless";
        capital-l = "serifless";
        capital-m = "hanging-serifless";
        capital-n = "standard-serifless";
        capital-p = "closed-serifless";
        capital-q = "crossing";
        capital-r = "standing-serifless";
        capital-s = "serifless";
        capital-t = "serifless";
        capital-u = "toothless-rounded-serifless";
        capital-v = "straight-serifless";
        capital-w = "straight-flat-top-serifless";
        capital-x = "straight-serifless";
        capital-y = "straight-serifless";
        capital-z = "straight-serifless";
        a = "double-storey-serifless";
        b = "toothed-serifless";
        c = "bilateral-inward-serifed";
        d = "toothed-serifless";
        e = "flat-crossbar";
        f = "flat-hook-serifless-crossbar-at-x-height";
        g = "single-storey-serifless";
        h = "straight-serifless";
        i = "serifed";
        j = "flat-hook-serifed";
        k = "symmetric-touching-serifless";
        l = "serifed";
        m = "serifless";
        n = "straight-serifless";
        p = "eared-serifless";
        q = "straight-serifless";
        r = "hookless-serifless";
        s = "serifless";
        t = "flat-hook-short-neck2";
        u = "toothed-serifless";
        v = "straight-serifless";
        w = "straight-flat-top-serifless";
        x = "straight-serifless";
        y = "straight-serifless";
        z = "straight-serifless";
        lower-theta = "oval";
        tittle = "square";
        diacritic-dot = "square";
        punctuation-dot = "square";
        braille-dot = "square";
        tilde = "low";
        asterisk = "penta-mid";
        underscore = "high";
        caret = "medium";
        ascii-grave = "straight";
        ascii-single-quote = "straight";
        paren = "flat-arc";
        brace = "curly-flat-boundary";
        guillemet = "straight";
        number-sign = "slanted";
        ampersand = "closed";
        at = "fourfold";
        dollar = "through";
        cent = "through-cap";
        percent = "rings-continuous-slash";
        bar = "natural-slope";
        question = "corner";
        pilcrow = "high";
        micro-sign = "toothed-serifless";
        decorative-angle-brackets = "middle";
        lig-ltgteq = "slanted";
        lig-neq = "slightly-slanted";
        lig-equal-chain = "without-notch";
        lig-hyphen-chain = "without-notch";
        lig-plus-chain = "without-notch";
        lig-double-arrow-bar = "without-notch";
        lig-single-arrow-bar = "without-notch";
      };

      weights = {
        Regular = {
          shape = 400;
          menu = 400;
          css = 400;
        };
        Bold = {
          shape = 700;
          menu = 700;
          css = 700;
        };
        # Building all these weights on a laptop will take a long time!
        # Medium = { shape = 500; menu = 500; css = 500; };
      };

      widths.Normal = {
        shape = 600;
        menu = 5;
        css = "normal";
      };

      slopes = {
        Upright = {
          angle = 0;
          shape = "upright";
          menu = "upright";
          css = "normal";
        };
        Italic = {
          angle = 11.8;
          shape = "italic";
          menu = "italic";
          css = "italic";
        };
      };

      metricOverride = {
        xHeight = 520;
        cap = 690;
        ascender = 740;
        sb = 100;
        leading = 1250;
        # For simple metrics, we use integers. For complex strings:
        dotSize = "blend(weight, [100, 110], [400, 125], [900, 150])";
      };
    };
  };
in
{
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
    flake = "/home/${user}/.config/beeb5kSystem/";
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
      load = true;
      save = true;
    };
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       user = "greeter";
  #       command = "${pkgs.tuigreet}/bin/tuigreet -t -r --remember-session -c mango";
  #     };
  #   };
  # };

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
    jack.enable = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    ioskeley-mono
    maple-mono.NF
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.defaultFonts.monospace = [
    "Ioskeley Mono"
    "Symbols Nerd Font"
  ];
  programs.fish.enable = true;
  programs.nano.enable = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.upower.enable = true;
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
