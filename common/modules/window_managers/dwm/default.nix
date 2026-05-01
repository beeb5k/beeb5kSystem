{
  homeManager,
  inputs,
<<<<<<< HEAD
=======
  moduleNameSpace,
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
<<<<<<< HEAD:common/modules/dwm/default.nix
<<<<<<< HEAD
  cfg = config.dwm;
in
{
  imports =
    if homeManager then
      [
        ./picom.nix
      ]
    else
      [ ];

  options.dwm = {
    enable = lib.mkEnableOption "dwm setup";
=======
  cfg = config.${moduleNameSpace}.dwm;
=======
  cfg = config.${moduleNameSpace}.windowManagers;
>>>>>>> cd08309 (Homecoming):common/modules/window_managers/dwm/default.nix
  snipx11 = pkgs.writeShellScript "snipx11" ''
    case $1 in
      full)
        ${pkgs.maim}/bin/maim | xclip -selection clipboard -t image/png
        ;;
      selection)
        ${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png
        ;;
      window)
        ${pkgs.maim}/bin/maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
        ;;
    esac
  '';
  st-patched =
    (pkgs.st.override {
      extraLibs = [ pkgs.libXcursor ];
    }).overrideAttrs
      (oldAttrs: rec {
        patches = map pkgs.fetchpatch [
          {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
            sha256 = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
          }
          {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff";
            sha256 = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
          }
          {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
            sha256 = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
          }
          {
            url = "https://st.suckless.org/patches/xresources/st-xresources-20230320-45a15676.diff";
            sha256 = "sha256-WcL9IeyanXFiOFDGGRU0QNT8DU7wSo2o+3n+TaqASUY=";
          }
          {
            url = "https://st.suckless.org/patches/vertcenter/st-vertcenter-20231003-eb3b894.diff";
            sha256 = "sha256-RbFNdGNi5HLAp1s8QOX3qsfxpkLcp1p/vksyZORN/uc=";
          }
          {
            url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
            hash = "sha256-yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
          }
          {
            url = "https://st.suckless.org/patches/csi_22_23/st-csi_22_23-0.8.5.diff";
            hash = "sha256-+izEkGVkLCbhZNBD2WN4uX5j+YMmou7JaMVmPG0mrYk=";
          }
          {
            url = "https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff";
            sha256 = "sha256-lys7/nup7a+GcmW+CutX0kjmbbOis2stkuhw02beuPs=";
          }
          {
            url = "https://st.suckless.org/patches/fix_keyboard_input/st-fix-keyboard-input-20180605-dc3b5ba.diff";
            sha256 = "sha256-h5ZrCj4IrkMQanLSMmgXaRd7qZYqvbzqUnuFt/axsMI=";
          }
          {
            url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
            sha256 = "sha256-WN/R6dPuw1eviHOvVVBw2VBSMDtfi1LCkXyX36EJKi4=";
          }
          # {
          #   url = "https://st.suckless.org/patches/themed_cursor/st-themed_cursor-0.8.1.diff";
          #   sha256 = "sha256-Q/6VN9oCrdJiZPPjKMpw3UB09tIs4eJ1Hi5c8k7O7uo=";
          # }
        ];

        postPatch = oldAttrs.postPatch or "" + ''
          sed -i 's/Button4, *kscrollup, *{.i = 1}/Button4, kscrollup, {.i = 10}/g' config.def.h
          sed -i 's/Button5, *kscrolldown, *{.i = 1}/Button5, kscrolldown, {.i = 10}/g' config.def.h

          sed -i 's/const int boxdraw = 0;/const int boxdraw = 1;/g' config.def.h
          sed -i 's/const int boxdraw_bold = 0;/const int boxdraw_bold = 1;/g' config.def.h

          grep -q Xcursor x.c || sed -i '/#include <X11\/XKBlib.h>/a #include <X11/Xcursor/Xcursor.h>' x.c

          sed -i 's/XCreateFontCursor/XcursorLibraryLoadCursor/g' x.c

          sed -i 's/static unsigned int mouseshape/static char *mouseshape/' config.def.h
          sed -i 's/XC_xterm/"ibeam"/' config.def.h

          sed -i 's/-lXft/-lXft -lXcursor/g' config.mk
        '';
      });
in
{
  imports = [
    #   (import ./picom.nix homeManager)
    (import ./scripts.nix homeManager)
  ];

<<<<<<< HEAD:common/modules/dwm/default.nix
  options.${moduleNameSpace}.dwm = {
    enable = lib.mkEnableOption "dwm setup";
    picom = {
      enable = lib.mkEnableOption "enable picom compositor";
      animations = lib.mkEnableOption "enable animations";
      shadow = lib.mkEnableOption "enable shadows";
      window = {
        opacity = {
          active = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };
          inactive = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };
        };
        blur = {
          enable = lib.mkEnableOption "Enable window blur";
          strength = lib.mkOption {
            type = lib.types.int;
            default = 1;
          };
          size = lib.mkOption {
            type = lib.types.int;
            default = 10;
          };
        };
      };
    };
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
  };

  config = lib.mkIf cfg.enable (
=======
  config = lib.mkIf cfg.dwm.enable (
>>>>>>> cd08309 (Homecoming):common/modules/window_managers/dwm/default.nix
    if !homeManager then
      {
<<<<<<< HEAD
        environment.systemPackages = with pkgs; [
          feh
          maim
          slop
          xdotool
          xclip
          (st.overrideAttrs (oldAttrs: rec {
            patches = map pkgs.fetchpatch [
              # {
              #   url = "https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.9.2.diff";
              #   sha256 = "sha256-/AoHajojVUAAqF4iKbN1lGM6h9PhZxCbMfAS2PRvbDE=";
              # }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
                sha256 = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
              }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff";
                sha256 = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
              }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
                sha256 = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
              }
              {
                url = "https://st.suckless.org/patches/xresources/st-xresources-20230320-45a15676.diff";
                sha256 = "sha256-WcL9IeyanXFiOFDGGRU0QNT8DU7wSo2o+3n+TaqASUY=";
              }
              {
                url = "https://st.suckless.org/patches/vertcenter/st-vertcenter-20231003-eb3b894.diff";
                sha256 = "sha256-RbFNdGNi5HLAp1s8QOX3qsfxpkLcp1p/vksyZORN/uc=";
              }
              {
                url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
                hash = "sha256-yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
              }
              {
                url = "https://st.suckless.org/patches/csi_22_23/st-csi_22_23-0.8.5.diff";
                hash = "sha256-+izEkGVkLCbhZNBD2WN4uX5j+YMmou7JaMVmPG0mrYk=";
              }
              {
                url = "https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff";
                sha256 = "sha256-lys7/nup7a+GcmW+CutX0kjmbbOis2stkuhw02beuPs=";
              }
              {
                url = "https://st.suckless.org/patches/fix_keyboard_input/st-fix-keyboard-input-20180605-dc3b5ba.diff";
                sha256 = "sha256-h5ZrCj4IrkMQanLSMmgXaRd7qZYqvbzqUnuFt/axsMI=";
              }
              {
                url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
                sha256 = "sha256-WN/R6dPuw1eviHOvVVBw2VBSMDtfi1LCkXyX36EJKi4=";
              }
            ];
            postPatch = oldAttrs.postPatch or "" + ''
              sed -i 's/Button4, *kscrollup, *{.i = 1}/Button4, kscrollup, {.i = 5}/g' config.def.h
              sed -i 's/Button5, *kscrolldown, *{.i = 1}/Button5, kscrolldown, {.i = 5}/g' config.def.h

              sed -i 's/const int boxdraw = 0;/const int boxdraw = 1;/g' config.def.h
              sed -i 's/const int boxdraw_bold = 0;/const int boxdraw_bold = 1;/g' config.def.h
              # sed -i 's/const int boxdraw_braille = 0;/const int boxdraw_braille = 1;/g' config.def.h
            '';
          }))
        ];

        services.xserver = {
          enable = true;
          autoRepeatDelay = 300;
          autoRepeatInterval = 20;
          excludePackages = with pkgs; [ xterm ];
          displayManager = {
            startx.enable = true;
          };
          windowManager.dwm = {
            enable = true;
            package = inputs.dwm.packages.${pkgs.stdenv.hostPlatform.system}.default;
          };
        };
      }
    else
      {
        home.file.".dwm/autostart.sh" = {
=======
        services.xserver = {
          enable = true;
          windowManager.dwm = {
            enable = true;
            package = inputs.mydwm.packages.${pkgs.stdenv.hostPlatform.system}.default;
          };
          autoRepeatDelay = 300;
          autoRepeatInterval = 20;
          excludePackages = with pkgs; [ xterm ];
          displayManager.sessionCommands = ''
            ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY XAUTHORITY XDG_SESSION_TYPE
            ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_SESSION_TYPE
          '';
        };

        programs.ssh.askPassword = "";
      }
    else
      {
        xdg.dataFile."dwm/autostart.sh" = {
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
          executable = true;
          text = ''
            #!${pkgs.bash}/bin/bash

<<<<<<< HEAD
            eval $(gnome-keyring-daemon --start --components=secrets,ssh)
            dbus-update-activation-environment --systemd --all &

            # xsetroot -cursor_name left_ptr &

            if [ -f ~/.fehbg ]; then
              sh ~/.fehbg &
            fi

            [ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &
            # xrandr --output eDP --set TearFree on

            ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

            dunst &
            clipcatd
            ${lib.optionalString (config.services.picom.enable) ''
              systemctl --user restart picom.service
            ''}
          '';
        };

        services.clipcat = {
          enable = config.dwm.enable;
=======
            gnome-keyring-daemon --start --components=secrets,ssh,pkcs11 &
            ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

            [ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

            dunst &
            clipcatd &
            slstatus &
            sync_dms
            systemctl --user restart xidlehook.service xautolock-session.service xss-lock.service clipcat.service
          '';
        };

        home.packages = with pkgs; [
          st-patched
          xdotool
          xclip
          (pkgs.dmenu.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or [ ]) ++ [
              (pkgs.fetchpatch {
                url = "https://tools.suckless.org/dmenu/patches/xresources/dmenu-xresources-4.9.diff";
                sha256 = "sha256-Np9I8hhnwmGA3W5v4tSrBN9Or8Q2Ag9x8H3yf8L9jDI=";
              })
            ];
          }))
        ];

        services.clipcat = {
          enable = false;
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
          daemonSettings = {
            daemonize = false;
            max_history = 50;
            desktop_notification = {
              enable = false;
            };
          };
          menuSettings = {
            server_endpoint = "/run/user/1000/clipcat/grpc.sock";
            finder = "rofi";

            rofi = {
              menu_length = 10;
              line_length = 100;
              menu_prompt = "Clipboard";
              extra_arguments = [ ];
            };
          };
        };

<<<<<<< HEAD
        xresources.extraConfig = ''
          #include "${config.xdg.configHome}/x11/matugen_st.Xresources"
        '';
=======
        systemd.user.services.clipcat = {
          Unit = {
            ConditionEnvironment = [ "XDG_SESSION_TYPE=x11" ];
          };
        };

        xresources.extraConfig = lib.mkIf config.beeMods.matugen.enable ''
          #include "${config.xdg.configHome}/x11/matugen.Xresources"
        '';

>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
        xresources.properties = {
          "Xft.dpi" = 96;
          "Xft.autohint" = 0;
          "Xft.antialias" = true;
          "Xft.hinting" = true;
          "Xft.lcdfilter" = "lcddefault";
          "Xft.hintstyle" = "hintfull";
          "Xft.rgba" = "rgb";
          "st.font" =
<<<<<<< HEAD
            "${config.terminal.font.family}:size=${toString config.terminal.font.size}:antialias=true:autohint=true";
=======
            "${config.beeMods.terminal.font.family}:size=${toString config.beeMods.terminal.font.size}:antialias=true:autohint=true";
          "dmenu.font" =
            "${config.beeMods.terminal.font.family}:size=${toString config.beeMods.terminal.font.size}";
<<<<<<< HEAD:common/modules/dwm/default.nix
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
          "st.borderpx" = 5;
=======
          "st.borderpx" = 2;
>>>>>>> cd08309 (Homecoming):common/modules/window_managers/dwm/default.nix
        };
      }
  );
}
