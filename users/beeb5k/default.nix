{
  systemState,
  user,
}: {
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = with inputs.self.homeModules; [
    inputs.beeb5kvim.homeModules.default
    programs
    mango
    dwm
    scripts
    ../users.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  mango = {
    enable = true;
    noctalia-shell = false;
  };
  dwm.enable = false;

  beebvim = {
    enable = true;
    packageDefinitions.replace =
      builtins.mapAttrs (n: _: {pkgs, ...}: {
        categories = {
          clang = false;
          markdown = false;
        };
      })
      inputs.beeb5kvim.packages.${pkgs.stdenv.hostPlatform.system}.default.packageDefinitions;
  };

  terminal = {
    emulator = {
      default = "foot";
      foot = true;
      alacritty = false;
      ghostty = false;
    };
    font = {
      family = "Lilex Nerd Font";
      size = 12.0;
      bright_color_is_bold = false;
      ligatures = false; # only supported by ghostty
    };
    window = {
      padding-x = 5;
      padding-y = 5;
    };
  };

  programs.mangohud.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = config.terminal.emulator.default;
  };

  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = false;
      arRPC = false;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = false;
      tray = false;
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      discordBranch = "stable";
      disableSmoothScroll = true;
      enableMenu = false;
    };
    vencord = {
      # themes = "midnight.css";
      settings = {
        enabledThemes = ["midnight.css"];
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = false;
        disableMinSize = true;
        plugins = {
          FakeNitro.enabled = true;
          AnonymiseFileNames.enabled = true;
          PlainFolderIcon.enabled = true;
          NoTypingAnimations.enabled = true;
          petpet.enabled = true;
          QuickReply.enabled = true;
          SilentTyping.enabled = true;
          StreamerModeOnStream.enabled = true;
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
    thunderbird
    (pkgs.obsidian.override {
      electron = pkgs.electron_40;
    })
  ];

  programs.home-manager.enable = true;
  home.stateVersion = systemState; # check flake.nix
}
