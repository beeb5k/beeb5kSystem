{
  systemState,
  user,
}:
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = with inputs.self.homeModules; [
<<<<<<< HEAD
    inputs.beeb5kvim.homeModules.default
    programs
    mango
    dwm
    hypr
    scripts
    ../users.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  hyprland = {
    enable = false;
    xwayland = true;
    animations = false;
    layout = "dwindle"; # master, scrolling  or dwindle
  };

  mango = {
    enable = true;
    animations = true;
    window = {
      blur.enable = true;
      blur.passes = 1;
      blur.radius = 10;
      border_radius = 0;
      shadows = true;
      opacity = 0.87;
    };
    noctalia-shell = false;
  };
  dwm.enable = true;

  beebvim = {
    enable = true;
    packageDefinitions.replace = builtins.mapAttrs (
      n: _:
      { pkgs, ... }:
      {
        settings = {
          neovim-unwrapped = pkgs.neovim-unwrapped;
        };
        categories = {
          clang = false;
          markdown = false;
        };
      }
    ) inputs.beeb5kvim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
  };

  terminal = {
    emulator = {
      default = "alacritty";
      foot = false;
      alacritty = true;
      ghostty = false;
    };
    font = {
      family = "Ioskeley Mono";
      size = 13.0;
      bright_color_is_bold = false;
      ligatures = false; # only supported by ghostty
    };
    window = {
      padding-x = 7;
      padding-y = 7;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = config.terminal.emulator.default;
  };

  programs.vesktop = {
    enable = true;
    vencord = {
      settings = {
        enabledThemes = [ "midnight.css" ];
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = false;
        disableMinSize = true;
        plugins = {
          FakeNitro.enabled = false;
          AnonymiseFileNames.enabled = true;
          PlainFolderIcon.enabled = true;
          NoTypingAnimation.enabled = true;
          NoF1.enabled = true;
          petpet.enabled = true;
          QuickReply.enabled = true;
          SilentTyping.enabled = true;
          StreamerModeOnStream.enabled = false;
          NoReplyMention.enabled = true;
          OnePingPerDM.enabled = false;
        };
      };
    };
  };

  home.packages = with pkgs; [
    opencode
    imagemagick
    pavucontrol
    matugen
    brightnessctl
    totem
    imv
    bluetui
    dunst
    gnome-calculator
    papers
    waybar
    cava
    playerctl
    (pkgs.obsidian.override {
      electron = pkgs.electron_40;
    })
  ];

  services.mpris-proxy.enable = true;

  programs.home-manager.enable = true;
=======
    ../common.nix
    beeMods
    programs
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;
  };

  beeMods = {
    windowManagers = {
      dwm.enable = true;
      hyprland.enable = true;
      mango.enable = false;
      eyeCandy = {
        animations.enable = true;
        window = {
          blur.enable = true;
          blur.radius = 12;
          blur.passes = 3;
          shadows.enable = true;
        };
      };
    };
    matugen.enable = true;
    emacs.enable = false;
    terminal = {
      foot = true;
      font.family = "IosevkaInput";
      font.size = 11.0;
    };
  };

  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = config.beeMods.terminal.default;
    TERM = config.beeMods.terminal.default;
  };

  programs.home-manager.enable = true;

<<<<<<< HEAD
  services.mpris-proxy.enable = true;

>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
=======
>>>>>>> cd08309 (Homecoming)
  home.stateVersion = systemState; # check flake.nix
}
